USE [TreeNSI_test]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/****************************************************************/
/****************************************************************/
/**           Helper ��� ����� �������� ������������           **/
/****************************************************************/
/****************************************************************/

--**************************************************************--
--** ��� ���������� ������ ����������, ����� COLLATE � �����  **--
--**      ������ ���� ����� ��, ��� ��� �� � �����!!!         **--
--**************************************************************--

print 'BEGIN InsertNomenckatureHelper ' + CONVERT(VARCHAR(50) ,GetDATE(), 113 )

IF(OBJECT_ID( N'usp_TreeNSI_serv_NomenclatureMorphologicalDuplicationCheck') IS NOT NULL)
DROP PROCEDURE [dbo].[usp_TreeNSI_serv_NomenclatureMorphologicalDuplicationCheck]
GO

--��������� ��������������� �������� ������� ����� ��������� ������������ � ����������� ������������

CREATE PROCEDURE [dbo].[usp_TreeNSI_serv_NomenclatureMorphologicalDuplicationCheck]
	(
	@name VARCHAR(300),            --����������� ������������
	@isGroup BIT,                  --��� ������ 
	@textError VARCHAR(1000) OUT   --����� ������  
	)

AS
SET NOCOUNT ON
BEGIN
	DECLARE @Return INT --���������� �������� ������
	SET @Return = 0

	DECLARE @words TABLE (idW INT NOT NULL IDENTITY(1,1), word VARCHAR(50), original VARCHAR(50), isMain INT)
	;
	WITH w (id, word, ost) --�������� ����� �� �����
	AS
		(SELECT 1 , 
			CASE WHEN CHARINDEX(' ',RTRIM(LTRIM(@name))) = 0 THEN RTRIM(LTRIM(@name)) ELSE 
			RTRIM(left(Ltrim(@name),CHARINDEX(' ',LTRIM(RTRIM(@name)),1))) END,
			CASE WHEN CHARINDEX(' ',RTRIM(LTRIM(@name))) = 0 THEN NULL ELSE
			 LTRIM(SUBSTRING(LTRIM(RTRIM(@name)),CHARINDEX(' ',LTRIM(RTRIM(@name)),1),LEN(LTRIM(RTRIM(@name)))- CHARINDEX(' ',LTRIM(RTRIM(@name)),1)+1)) END
		UNION ALL
			SELECT id+1, CASE WHEN CHARINDEX(' ',LTRIM(RTRIM(ost)),1) = 0 THEN ost ELSE RTRIM(LEFT(Ltrim(ost),CHARINDEX(' ',LTRIM(RTRIM(ost)),1))) END,
			CASE WHEN CHARINDEX(' ',LTRIM(RTRIM(ost)),1) = 0 THEN NULL ELSE LTRIM(SUBSTRING(LTRIM(RTRIM(ost)),CHARINDEX(' ',LTRIM(RTRIM(ost)),1),LEN(LTRIM(RTRIM(ost)))- CHARINDEX(' ',LTRIM(RTRIM(ost)),1)+1)) END FROM w
		WHERE ost IS NOT NULL
		)

	INSERT INTO @words --������� �������� ����
	SELECT word, word, NULL FROM w

	--����������� �������� ����
	UPDATE @words
	SET isMain = CASE WHEN CHARINDEX('.',word,1) > 1 THEN 
						CASE WHEN word LIKE '%'+'[0123456789].%' THEN 1 
							WHEN word LIKE '%'+'[0123456789],[0123456789]%' THEN 1
						ELSE 0 END
				ELSE
					--����� ���---
					CASE WHEN LEN(word) > 2 THEN 1
						WHEN LEN(word) = 1 THEN 
						CASE WHEN '�����' = ANY ( SELECT Word FROM @words ) THEN 2		--����������������� �����
							WHEN '�����' = ANY ( SELECT Word FROM @words ) THEN 2
							WHEN '�����' = ANY ( SELECT Word FROM @words ) THEN 2
							WHEN '������' = ANY ( SELECT Word FROM @words ) THEN 2
							WHEN '���' = ANY ( SELECT Word FROM @words ) THEN 2
							WHEN '����' = ANY ( SELECT Word FROM @words ) THEN 2
							WHEN '����' = ANY ( SELECT Word FROM @words ) THEN 2
							WHEN '�����' = ANY ( SELECT Word FROM @words ) THEN 2
							WHEN word IN ('�','�','�','�') THEN 2						--��������� �����
							/*��� �������*/
						 ELSE 0 END
					ELSE 
						CASE WHEN word LIKE '%[0123456789QWERTYUIOPASDFGHJKLZXCVBNM]%' THEN 1 ELSE 0 END 
					END 
				END 

	UPDATE @words
	SET word = REPLACE(REPLACE(REPLACE(REPLACE(word,'-',''),'/',''),'(',''),')','')

	UPDATE @words
	SET word = REPLACE(word,',','')
	WHERE isMain > 1 AND word NOT LIKE '%'+'[0123456789],[0123456789]%'

	DECLARE @len INT
	SET @len = (SELECT ISNULL(SUM(kol),0) FROM (SELECT kol = LEN(word) FROM @words WHERE isMain > 0) a)



	--select * from @words
	IF @len < 3 
		BEGIN
			SET @textError = '������� ���� ����������' 
			SET @Return = -1
			RETURN @Return
		END



	; WITH words (idW, word, isMain)
	AS
		(SELECT idw = ROW_NUMBER() OVER (ORDER BY idw),
		word, isMain FROM @words WHERE isMain > 0)

	,z (productId, name, step)
	AS
		--(SELECT p.productId, p.productName, t.idW FROM view_products p 
		--**������������ ���� � �������� ���������, ����� ������� �� ������ ���� ������� � ����������� ���������� ������ (�� � �������) ������������**--
		(SELECT p.IdNomenclature, p.Name, t.idW FROM 
		(SELECT DISTINCT n.IdNomenclature, name = ISNULL(pr.FullName, n.Name) FROM dbo.TreeNSI_Nomenclature n --������� ���� ��������� ��� ��������� �������� ������������ (���� ���� ����� ������� ��������� ����� ����� ��� ���, ��� ����� ������, ��, ��������, ����� ������� ��������� ������������
		LEFT JOIN dbo.TreeNSI_NomenclatureProperty pr ON pr.IdElement = n.IdNomenclature
		WHERE n.IsActive = 1 AND 1 = CASE WHEN @isGroup IS NULL THEN 1 ELSE CASE WHEN @isGroup = n.IsGroup THEN 1 ELSE 0 END END) p
		JOIN words t ON t.idW = (SELECT MIN(idW) FROM words WHERE isMain > 0) 
		AND REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(p.name,'-',''),'/',''),'(',''),')',''),'.',' ') 
		LIKE '%'+REPLACE(CASE WHEN t.word like '[0123456789QWERTYUIOPASDFGHJKLZXCVBNM����]'+SUBSTRING(t.word,2,LEN(t.word)-1) THEN ' '+t.word ELSE t.word END,'.',' ')+'%' 
		AND len(p.name) >= @len /*AND p.isActive = 1 AND 1 = CASE WHEN @isGroup IS NULL THEN 1 ELSE CASE WHEN @isGroup = p.isGroup THEN 1 ELSE 0 END END*/
		UNION ALL
		SELECT z.productId, z.name, t.idW FROM z
		JOIN words t ON t.idW = z.step +1 
		AND t.isMain > 0 AND REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(z.name,'-',''),'/',''),'(',''),')',''),'.',' ') 
		LIKE '%'+REPLACE(CASE WHEN t.word LIKE '[0123456789QWERTYUIOPASDFGHJKLZXCVBNM����]'+SUBSTRING(t.word,2,LEN(t.word)-1) THEN ' '+t.word ELSE t.word END,'.',' ')+'%'
		)
	, az (id, code,name)
	AS
		(SELECT id = ROW_NUMBER() OVER (ORDER BY productId), productId, name FROM z
		WHERE z.step = (SELECT count(*) FROM @words WHERE isMain > 0 ))
	, nn (id, name)
	AS
		(SELECT id, CAST('['+CAST(code AS VARCHAR) + '] ' + name AS VARCHAR(1000)) FROM az
		WHERE id = 1
		UNION ALL
		SELECT az.id, CAST(nn.name + '; ['+CAST(az.code AS VARCHAR) + '] ' + az.name AS VARCHAR(1000)) FROM nn
		JOIN az ON az.id = nn.id+1 
		WHERE LEN(nn.name + '; ['+CAST(az.code AS VARCHAR) + '] ' + az.name) < 1000
		)

	SELECT @Return = id, @textError = name FROM nn WHERE id = (SELECT MAX(id) FROM nn)
	RETURN ISNULL(@Return,0)
	
END

GO
DECLARE @result VARCHAR(10) = ' /FAIL'
IF(OBJECT_ID( N'usp_TreeNSI_serv_NomenclatureMorphologicalDuplicationCheck') IS NOT NULL)
	SET @result = ' /OK'
print 'CREATE PROCEDURE [dbo].[usp_TreeNSI_serv_NomenclatureMorphologicalDuplicationCheck]' + @result

/************* ���� �������� ����� *************/
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'��������� ��������������� �������� �� ������������ ������������ � ����������� ������������. �������� ���������� ��������� ������' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'usp_TreeNSI_serv_NomenclatureMorphologicalDuplicationCheck'
GO
/************* ����� ����� �������� ����� *************/

IF(OBJECT_ID( N'usp_TreeNSI_AddBaseNomenclature') IS NOT NULL)
DROP PROCEDURE [dbo].[usp_TreeNSI_AddBaseNomenclature]
GO

--��������� ���������� ������ �������� ����������� ������������ (���������� ����������� ������������ ����������)

CREATE PROCEDURE [dbo].[usp_TreeNSI_AddBaseNomenclature]
	(
	@Name VARCHAR(300),									-- ������������ ��� ������
	@IsGroup BIT,										-- ��� ������
	@ParentId INT = NULL,								-- ��� ������������ ������ � ����������� ������������ (IdNomenclature)
	@FullName VARCHAR(300) = NULL,						-- ������ ������������
	@BeginDate DATETIME = NULL,							-- ���� ��������� ������������� ����������
	@baseMeasurementUnit INT = NULL,					-- �������� ������� ���������
	@VolumeMeashurementUnit INT=NULL,					-- ������� ��������� ������-�������� ��������������
	@Volume DECIMAL(9,6)=NULL,							-- ����� (�����) ������� ���������
	@CutOffMorphologicalDuplicationCheck BIT = NULL,	--�������������� ���������� ��������������� �������� (������ ������ � ���������� ������� ������� ���, ��� ���� ������������)
	
	@user INT = NULL,									-- ��� ������������ � ������� TreeNSI
	@returnId INT  = NULL OUTPUT						-- ���������� ��� ������������ (IdNomenclature)
	)

AS
SET NOCOUNT ON
BEGIN
	
	SET @returnId = -1
	--��������� ���������--
	DECLARE @IdProcedure INT         --��������� ��� ���������
	SET @IdProcedure =  OBJECT_ID(N'dbo.usp_TreeNSI_AddBaseNomenclature')
	DECLARE @parameters XML          --������� ���������
	SET @parameters = (SELECT @Name AS 'Name', @IsGroup AS 'IsGroup', @ParentId AS 'ParentId', @FullName AS 'FullName', @BeginDate AS 'BeginDate', @user AS 'user', @returnId AS 'returnId' FOR XML RAW) 
	DECLARE @directoryType INT       --��� �����������
	SET @directoryType = 1
	DECLARE @ErrorText VARCHAR(1000) --����� ������
	--***********************--

	

	SET @user = ISNULL(@user,(SELECT dbo.udf_TreeNSI_GetIdUser()))
	IF @user IS NULL OR (SELECT dbo.udf_TreeNSI_serv_CheckUser(@user)) = 0
		BEGIN
			SET @ErrorText = '������������ � ����� '+CAST(@user AS VARCHAR)+' ('+USER+') �� �������� �������� ������������� �������'
			EXEC	[dbo].[usp_TreeNSI_serv_WriteErrorLog]	@isFatalError = 1, @text = @ErrorText,	@user = @user,	@directoryType = @directoryType, @idElement = NULL,	@ErrorSource = @IdProcedure, @Parameters = @parameters

			RETURN
		END

	SET @Name = REPLACE(@Name,'"','')
	SET @Name = REPLACE(@Name,'''','')
	SET @Name = REPLACE(@Name,'  ',' ')
	SET @Name = REPLACE(@Name,'  ',' ')

	SET @Name = RTRIM(LTRIM(ISNULL(@Name,'')))
	IF LEN(@Name) < 3 OR ISNUMERIC(@Name) = 1
		BEGIN
			SET @ErrorText = '������� ���� ���������� ��� ������'
			EXEC	[dbo].[usp_TreeNSI_serv_WriteErrorLog]	@isFatalError = 1, @text = @ErrorText,	@user = @user,	@directoryType = @directoryType, @idElement = NULL,	@ErrorSource = @IdProcedure, @Parameters = @parameters

			RETURN
		END


	IF @IsGroup IS NULL
		BEGIN
			SET @ErrorText = '����������� ������� ������'
			EXEC	[dbo].[usp_TreeNSI_serv_WriteErrorLog]	@isFatalError = 1, @text = @ErrorText,	@user = @user,	@directoryType = @directoryType, @idElement = NULL,	@ErrorSource = @IdProcedure, @Parameters = @parameters

			RETURN
		END

	--�������� �� ������� ��������--
	IF @ParentId IS NOT NULL
		BEGIN
			IF (SELECT COUNT(*) FROM dbo.TreeNSI_Nomenclature WHERE IdNomenclature = @ParentId AND IsGroup = 1) = 0
				BEGIN
					SET @ParentId = NULL
					SET @ErrorText = '�� ������� ��������� ������������ ������'
					EXEC	[dbo].[usp_TreeNSI_serv_WriteErrorLog]	@isFatalError = 0, @text = @ErrorText,	@user = @user,	@directoryType = @directoryType, @idElement = NULL,	@ErrorSource = @IdProcedure, @Parameters = @parameters

				END
		END

	--�������������� �������� �� ����������--
	DECLARE @return_value INT --���������� ������� �������
	EXEC	@return_value = [dbo].[usp_TreeNSI_serv_NomenclatureMorphologicalDuplicationCheck]
		@name = @Name,
		@isGroup = @IsGroup,
		@textError = @ErrorText OUTPUT

	IF (@return_value != 0)
		BEGIN
			
			--��������, �������� ������ ����� ������� ������ ��-�� ����� ����� ������� ��� �������� 
			IF NOT(@IsGroup = 0 AND @Name LIKE (SELECT Name + '%' FROM TreeNSI_Nomenclature WHERE IdNomenclature = @ParentId))
				BEGIN
					
					IF ISNULL(@CutOffMorphologicalDuplicationCheck,0) = 1
						BEGIN
							IF(SELECT IdRole FROM TreeNSI_ssmUserRoles WHERE IdUser = @user) = 1 
								BEGIN
									SET @ErrorText = CASE WHEN @return_value < 0 THEN @ErrorText ELSE '�������������� ������. �������� ����������� ������������ ������ ('+CAST(@return_value AS VARCHAR)+' ������� �������): '+CASE WHEN LEN(@ErrorText) > 970 THEN LEFT(@ErrorText,969) ELSE @ErrorText END END
									EXEC	[dbo].[usp_TreeNSI_serv_WriteErrorLog]	@isFatalError = 0, @text = @ErrorText,	@user = @user,	@directoryType = @directoryType, @idElement = NULL,	@ErrorSource = @IdProcedure, @Parameters = @parameters
								END
							ELSE
								BEGIN
									SET @ErrorText = CASE WHEN @return_value < 0 THEN @ErrorText ELSE '�������� ����������� ������������ ������ ('+CAST(@return_value AS VARCHAR)+' ������� �������): '+CASE WHEN LEN(@ErrorText) > 970 THEN LEFT(@ErrorText,969) ELSE @ErrorText END END
									EXEC	[dbo].[usp_TreeNSI_serv_WriteErrorLog]	@isFatalError = 1, @text = @ErrorText,	@user = @user,	@directoryType = @directoryType, @idElement = NULL,	@ErrorSource = @IdProcedure, @Parameters = @parameters

									RETURN

								END

						END
					ELSE
						BEGIN
							SET @ErrorText = CASE WHEN @return_value < 0 THEN @ErrorText ELSE '�������� ����������� ������������ ������ ('+CAST(@return_value AS VARCHAR)+' ������� �������): '+CASE WHEN LEN(@ErrorText) > 970 THEN LEFT(@ErrorText,969) ELSE @ErrorText END END
							EXEC	[dbo].[usp_TreeNSI_serv_WriteErrorLog]	@isFatalError = 1, @text = @ErrorText,	@user = @user,	@directoryType = @directoryType, @idElement = NULL,	@ErrorSource = @IdProcedure, @Parameters = @parameters

							RETURN
						END
				END
		END

	--����� ��������� � ������ ������������ (��� ������, ����� ������� ������ ��������� � ������)
	SET @FullName = RTRIM(LTRIM(ISNULL(@FullName,'')))
	IF LEN(@FullName) > LEN(@Name)
		BEGIN
			SET @FullName = REPLACE(@FullName,'  ',' ')
			SET @FullName = REPLACE(@FullName,'  ',' ')
			EXEC	@return_value = [dbo].[usp_TreeNSI_serv_NomenclatureMorphologicalDuplicationCheck]
				@name = @FullName,
				@isGroup = @IsGroup,
				@textError = @ErrorText OUTPUT

			IF (@return_value != 0)
				BEGIN
					
					--��������, �������� ������ ����� ������� ������ ��-�� ����� ����� ������� ��� �������� 
					IF NOT(@IsGroup = 0 AND @Name LIKE (SELECT Name + '%' FROM TreeNSI_Nomenclature WHERE IdNomenclature = @ParentId))
						BEGIN
							
							IF ISNULL(@CutOffMorphologicalDuplicationCheck,0) = 1
								BEGIN
									IF(SELECT IdRole FROM TreeNSI_ssmUserRoles WHERE IdUser = @user) = 1 
										BEGIN
											SET @ErrorText = CASE WHEN @return_value < 0 THEN @ErrorText ELSE '�������������� ������. �������� ����������� ������������ ������ ('+CAST(@return_value AS VARCHAR)+' ������� �������): '+CASE WHEN LEN(@ErrorText) > 970 THEN LEFT(@ErrorText,969) ELSE @ErrorText END END
											EXEC	[dbo].[usp_TreeNSI_serv_WriteErrorLog]	@isFatalError = 0, @text = @ErrorText,	@user = @user,	@directoryType = @directoryType, @idElement = NULL,	@ErrorSource = @IdProcedure, @Parameters = @parameters
										END
									ELSE
										BEGIN
											SET @ErrorText = CASE WHEN @return_value < 0 THEN @ErrorText ELSE '�������� ����������� ������������ ������ ('+CAST(@return_value AS VARCHAR)+' ������� �������): '+CASE WHEN LEN(@ErrorText) > 970 THEN LEFT(@ErrorText,969) ELSE @ErrorText END END
											EXEC	[dbo].[usp_TreeNSI_serv_WriteErrorLog]	@isFatalError = 1, @text = @ErrorText,	@user = @user,	@directoryType = @directoryType, @idElement = NULL,	@ErrorSource = @IdProcedure, @Parameters = @parameters

											RETURN

										END

								END
							ELSE
								BEGIN
									SET @ErrorText = CASE WHEN @return_value < 0 THEN @ErrorText ELSE '�������� ����������� ������������ ������ ('+CAST(@return_value AS VARCHAR)+' ������� �������): '+CASE WHEN LEN(@ErrorText) > 970 THEN LEFT(@ErrorText,969) ELSE @ErrorText END END
									EXEC	[dbo].[usp_TreeNSI_serv_WriteErrorLog]	@isFatalError = 1, @text = @ErrorText,	@user = @user,	@directoryType = @directoryType, @idElement = NULL,	@ErrorSource = @IdProcedure, @Parameters = @parameters

									RETURN
								END
						END
				END
		END

	

	--������� ����������� � ��������
	DECLARE @idCatalog INT, @DateRegistration DATETIME
	BEGIN TRY
		BEGIN TRANSACTION
			EXEC	[dbo].[usp_TreeNSI_DirectoryRegistration]
				@directoryType = @directoryType,
				@user = @user,
				@returnId = @idCatalog OUTPUT,
				@returnRegistrationDate = @DateRegistration OUTPUT

			--������ � ������� 
	
			INSERT INTO [dbo].[TreeNSI_Nomenclature]
				   ([IdCatalog]
				   ,[IsGroup]
				   ,[ParentId]
				   ,[Name]
				   ,[IsActive])
			 VALUES
				   (@idCatalog
				   ,@IsGroup
				   ,@ParentId
				   ,@Name
				   ,1)
			SET @returnId = CAST(SCOPE_IDENTITY() AS INT)
		--COMMIT TRANSACTION --���� ����������� ����
	END TRY

	BEGIN CATCH
		IF ISNULL(@idCatalog,-1) = -1
			BEGIN
				ROLLBACK TRANSACTION
				SET @ErrorText = '�� ������� ���������������� ����� ������� � ��������'
				EXEC	[dbo].[usp_TreeNSI_serv_WriteErrorLog]	@isFatalError = 1, @text = @ErrorText,	@user = @user,	@directoryType = @directoryType, @idElement = NULL,	@ErrorSource = @IdProcedure, @Parameters = @parameters

		   
				RETURN
			END

		
		IF @returnId IS NULL OR @returnId = -1
			BEGIN
				ROLLBACK TRANSACTION
				SET @ErrorText = '�� ������� �������� ����� ������� '+ LEFT(ISNULL(ERROR_MESSAGE(),''),CASE WHEN LEN(ISNULL(ERROR_MESSAGE(),''))> 945 THEN 945 ELSE LEN(ISNULL(ERROR_MESSAGE(),'')) END)
				EXEC	[dbo].[usp_TreeNSI_serv_WriteErrorLog]	@isFatalError = 1, @text = @ErrorText,	@user = @user,	@directoryType = @directoryType, @idElement = NULL,	@ErrorSource = @IdProcedure, @Parameters = @parameters

				SET @returnId = -1
	
				RETURN
			END
	END CATCH
	
	--������� �������� ������ ������������--
	
	IF LEN(@FullName) >= LEN(@Name) AND ISNUMERIC(@FullName) = 0 
		BEGIN
			
			INSERT INTO [dbo].[TreeNSI_NomenclatureProperty]
				   ([IdElement]
				   ,[BeginDate]
				   ,[FullName]
				   ,[IdClassProduct]
				   ,[IdCommonCustomsTariff]
				   ,[IdCargoesHarmonizedNomenclature])
			 VALUES
				   (@returnId
				   ,ISNULL(@BeginDate,@DateRegistration)
				   ,@FullName
				   ,NULL
				   ,NULL
				   ,NULL)

		END
	ELSE
		BEGIN
			IF ISNULL(@CutOffMorphologicalDuplicationCheck,0) = 1
				BEGIN
					IF(SELECT IdRole FROM TreeNSI_ssmUserRoles WHERE IdUser = @user) = 1 
						BEGIN
							SET @ErrorText = CASE WHEN @return_value < 0 THEN @ErrorText ELSE '�������������� ������. ������ ������������ ������ ��������! '+CASE WHEN LEN(@ErrorText) > 970 THEN LEFT(@ErrorText,969) ELSE @ErrorText END END
							EXEC	[dbo].[usp_TreeNSI_serv_WriteErrorLog]	@isFatalError = 0, @text = @ErrorText,	@user = @user,	@directoryType = @directoryType, @idElement = NULL,	@ErrorSource = @IdProcedure, @Parameters = @parameters
						END
					ELSE
						BEGIN
							ROLLBACK TRANSACTION
							SET @ErrorText = '������������ ������ ������������ �� ������ ���� ������ �������� '+ LEFT(ISNULL(ERROR_MESSAGE(),''),CASE WHEN LEN(ISNULL(ERROR_MESSAGE(),''))> 945 THEN 945 ELSE LEN(ISNULL(ERROR_MESSAGE(),'')) END)
							EXEC	[dbo].[usp_TreeNSI_serv_WriteErrorLog]	@isFatalError = 1, @text = @ErrorText,	@user = @user,	@directoryType = @directoryType, @idElement = NULL,	@ErrorSource = @IdProcedure, @Parameters = @parameters

							SET @returnId = -1
	
							RETURN
						END
				END
			ELSE
				BEGIN
					ROLLBACK TRANSACTION
						SET @ErrorText = '������������ ������ ������������ �� ������ ���� ������ �������� '+ LEFT(ISNULL(ERROR_MESSAGE(),''),CASE WHEN LEN(ISNULL(ERROR_MESSAGE(),''))> 945 THEN 945 ELSE LEN(ISNULL(ERROR_MESSAGE(),'')) END)
						EXEC	[dbo].[usp_TreeNSI_serv_WriteErrorLog]	@isFatalError = 1, @text = @ErrorText,	@user = @user,	@directoryType = @directoryType, @idElement = NULL,	@ErrorSource = @IdProcedure, @Parameters = @parameters

						SET @returnId = -1
	
						RETURN
				END

		END
	COMMIT TRANSACTION --����� ���� �������������� ������

	--������� �������� ������ �� ������� ������� ���������
	IF @baseMeasurementUnit IS NOT NULL
		BEGIN
			IF(SELECT COUNT(*) FROM TreeNSI_MeasurementUnit WHERE IdMeasurementUnit = @baseMeasurementUnit) = 1
				BEGIN
					INSERT INTO [dbo].[TreeNSI_NomenclatureMeasurementUnit]
						   ([IdNomenclature]
						   ,[IdMeasurementUnit]
						   ,[IsBaseUnit])
					 VALUES
						   (@returnId
						   ,@baseMeasurementUnit
						   ,1)

					IF (SELECT ParentId FROM TreeNSI_MeasurementUnit WHERE IdMeasurementUnit = @baseMeasurementUnit) = 7 --������������� �������, ������ ����� �����, ����� � �.�.
					AND (SELECT ParentId FROM TreeNSI_MeasurementUnit WHERE IdMeasurementUnit = @VolumeMeashurementUnit) IN (3,4)
					AND ISNULL(@Volume,0) > 0  AND @IsGroup = 0 --��� ������ ����������� �����-�������� �������������� ���-�� ���������
						BEGIN

							INSERT INTO [dbo].[TreeNSI_NomenclatureProductProperty]
							([IdNomenclature]
							,[GTINCode]
							,[MassVolumeMeashurementUnit]
							,[MassVolume])
								VALUES
							(@returnId
							,NULL
							,@VolumeMeashurementUnit
							,@Volume)

							--����� ����� ���������� ������� ����������� ������
							INSERT INTO [dbo].[TreeNSI_Nomenclature_NoneclatureType]
							([IdNomenclature]
							,[IdNomenclatureType])
								VALUES
							(@returnId
							,18) --���������� �����
						END
					ELSE
						IF @VolumeMeashurementUnit IS NOT NULL AND ISNULL(@Volume ,0) != 0
							BEGIN
								SET @ErrorText = '�����-�������� �������������� ������������ �� ���������'
								EXEC	[dbo].[usp_TreeNSI_serv_WriteErrorLog]	@isFatalError = 0, @text = @ErrorText,	@user = @user,	@directoryType = @directoryType, @idElement = NULL,	@ErrorSource = @IdProcedure, @Parameters = @parameters
							END

				END
			ELSE
				BEGIN
					SET @ErrorText = '������� �������� �������� ������� ���������'
					EXEC	[dbo].[usp_TreeNSI_serv_WriteErrorLog]	@isFatalError = 0, @text = @ErrorText,	@user = @user,	@directoryType = @directoryType, @idElement = NULL,	@ErrorSource = @IdProcedure, @Parameters = @parameters
				END
		END

END

GO

DECLARE @result VARCHAR(10) = ' /FAIL'
IF(OBJECT_ID( N'usp_TreeNSI_AddBaseNomenclature') IS NOT NULL)
	SET @result = ' /OK'
print 'CREATE PROCEDURE [dbo].[usp_TreeNSI_AddBaseNomenclature]' + @result

/************* ���� �������� ����� *************/
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'���������� ������ �������� ����������� ������������ (����������� ����� ������)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'usp_TreeNSI_AddBaseNomenclature'
GO
/************* ����� ����� �������� ����� *************/

print 'END InsertNomenckatureHelper ' + CONVERT(VARCHAR(50) ,GetDATE(), 113 )