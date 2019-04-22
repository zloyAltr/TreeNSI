USE [TreeNSI_test]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/****************************************************************/
/****************************************************************/
/**        Helper ��� ����� �������� � ���������� ������       **/
/****************************************************************/
/****************************************************************/

--***************************************************************--
--**  ��� ���������� ������ ����������, ����� COLLATE � �����  **--
--**       ������ ���� ����� ��, ��� ��� �� � �����!!!         **--
--***************************************************************--

--***************************************************************--
--**   ��� ���������� ������ ��������� ����������� ����������  **--
--**         TreeNSI_Addr_AdministrativTerritorialUnit         **--
--***************************************************************--

--***************************************************************--
--**  ��� ���������� ������ ���������� ����������� ����������� **--
--** TreeNSI_Addr_AdministrativTerritorialUnit, TreeNSI_Country**--
--***************************************************************--

--****************************************************************--
--**��� �������������� ������ ���������� ����������� �����������**--
--**         TreeNSI_Addr_AddressesClassifierBY_Locality        **--
--**         TreeNSI_Addr_AddressesClassifierRU_Locality        **--
--****************************************************************--

print 'BEGIN InsertAddressHelper ' + CONVERT(VARCHAR(50) ,GetDATE(), 113 )

IF(OBJECT_ID( N'udf_TreeNSI_CheckATUCenterLocalityBY') IS NOT NULL)
DROP FUNCTION [dbo].[udf_TreeNSI_CheckATUCenterLocalityBY]
GO

--��������, �������� �� ���������� ����� �� ������� ����������������� �������� �������� ������

CREATE FUNCTION [dbo].[udf_TreeNSI_CheckATUCenterLocalityBY]
(--�������� �� ������. ���� ��� ����������: � ��������� ����������� ����� ��������������/���������������� ��������� ����� � ��������, ��� �������, � � �� �������)
@IdClassifierLocality INT -- ����������� ��� � �����������, ��� ������ ����� ���������, �������� �� �� ���������������� �������
)
RETURNS BIT --0- ��� �� ���������������� �����, 1 - ���������������� �����
AS
BEGIN

--------*****************************************------------------------------
DECLARE @return BIT 
SET @return = 0


DECLARE @Type VARCHAR(3), @Level INT, @Code VARCHAR(10), @Name VARCHAR(300)

;WITH dat (id, DD)
AS
(SELECT IdElement, MAX(BeginDate) FROM TreeNSI_Addr_AddressesClassifierBY_LocalityProperty
GROUP BY IdElement)
SELECT @Name = LTRIM(prop.Name),
@Code = prop.Code,
@Type = prop.LocalityTypeCode
FROM TreeNSI_Addr_AddressesClassifierBY_LocalityProperty prop
JOIN dat ON dat.id = prop.IdElement AND dat.DD = prop.BeginDate
WHERE prop.IdElement = @IdClassifierLocality

IF @Name IS NULL
RETURN 0 --������ �� �������

IF RIGHT(@Code,9) = REPLICATE('0',9)
RETURN 1 --��� �����

IF @Type IN ('101','102','103','202')
RETURN 0 --��� �� ���������� ������

SET @Name = LEFT(@Name,LEN(@Name)-2)+'%'

;
WITH A (id, dd)
AS
(SELECT [IdElement], MAX([BeginDate]) FROM [TreeNSI_Addr_AddressesClassifierBY_LocalityProperty]
GROUP BY IdElement
)

SELECT  @return = CASE WHEN COUNT(*) = 1 THEN CAST(1 AS bit) ELSE CAST(0 AS bit) END
  FROM [dbo].[TreeNSI_Addr_AddressesClassifierBY_LocalityProperty] l
  JOIN A ON A.id = l.IdElement AND l.BeginDate = A.dd
  WHERE l.Name LIKE @Name 
  AND l.Code = CASE WHEN RIGHT(@Code,6) = REPLICATE('0',6) THEN LEFT(@Code,1)+REPLICATE('0',9)
	 WHEN RIGHT(@Code,3) = REPLICATE('0',3) THEN LEFT(@Code,4)+REPLICATE('0',6)
	 ELSE LEFT(@Code,7)+REPLICATE('0',3) END
  AND l.LocalityTypeCode IN ('101','102','103')

RETURN @return

END

GO

DECLARE @result VARCHAR(10) = ' /FAIL'
IF(OBJECT_ID( N'udf_TreeNSI_CheckATUCenterLocalityBY') IS NOT NULL)
	SET @result = ' /OK'
print 'CREATE FUNCTION [dbo].[udf_TreeNSI_CheckATUCenterLocalityBY]' + @result

/************* ���� �������� ����� *************/
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'�������� ��� �� ��, ��� �� ���������������� ����� � ��' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'FUNCTION',@level1name=N'udf_TreeNSI_CheckATUCenterLocalityBY'
GO
/************* ����� ����� �������� ����� *************/

IF(OBJECT_ID( N'usp_TreeNSI_AddATUFromClassifierLocalityBY') IS NOT NULL)
DROP PROCEDURE [dbo].[usp_TreeNSI_AddATUFromClassifierLocalityBY]
GO

--��������� ���������� ������ ��� �� ������ ����� ��� ��

CREATE PROCEDURE [dbo].[usp_TreeNSI_AddATUFromClassifierLocalityBY]
	(
	@IdClassifierLocality INT --�������� ��������
	)

AS
SET NOCOUNT ON
BEGIN
	
	DECLARE @IdATU INT --��������� ��� ��� (�� ������)
	SET @IdATU = 0 -- �������� �� ���������, ������� �������


	--��������� ���������--
	DECLARE @IdProcedure INT         --��������� ��� ���������
	SET @IdProcedure =  OBJECT_ID(N'dbo.usp_TreeNSI_AddATUFromClassifierLocalityBY')
	DECLARE @parameters XML          --������� ���������
	SET @parameters = (SELECT @IdClassifierLocality AS 'IdClassifierLocality' FOR XML RAW) 
	DECLARE @directoryType INT       --��� �����������
	SET @directoryType = NULL
	DECLARE @ErrorText VARCHAR(1000) --����� ������
	--***********************--

	DECLARE @user INT --������������, ������� �������� ���-�� �������
	SET @user = (SELECT dbo.udf_TreeNSI_GetIdUser())
		
	--������� ������������� ���� ���
	DECLARE @T TABLE (Id VARCHAR(3), IdTYpeATU INT, IsGroup BIT)
	INSERT INTO @T
	(
	Id, IdTYpeATU, IsGroup )
	VALUES
	('101',5,1)
	,('102',7,1)
	,('103',11,1)
	,('111',13,0)
	,('112',13,0)
	,('113',13,0)
	,('121',61,0)
	,('122',15,0)
	,('123',17,0)
	--,('202',null,0) --��������������� �����
	,('213',13,0)
	,('221',61,0)
	,('222',15,0)
	,('223',17,0)
	,('231',25,0)
	,('232',29,0)
	,('233',30,0)
	,('234',53,0)
	,('235',60,0)
	--,('239',null,0) --����			
	
	DECLARE @ParentCode VARCHAR(10), @ParentIdClassifierLocality INT, @ParentName VARCHAR(300), @ParentIdType INT

	DECLARE @Code VARCHAR(10),
	@IdType INT,
	@Name VARCHAR(300),
	@IsGroup BIT,
	@ParentId INT --��� ��� �������� (��� ����������)

	DECLARE @KolATU INT --��� ������ ������������� ���������


	--��������� ������ �� �������� ���
	;WITH H (Id,DD)
	AS
	(
	SELECT P.IdElement, MAX(P.BeginDate) FROM TreeNSI_Addr_AddressesClassifierBY_LocalityProperty P
	WHERE P.IdElement = @IdClassifierLocality
	GROUP BY P.IdElement
	)
	SELECT 
	@Code = LTRIM(P.Code),
	@Name = LTRIM(P.Name),
	@IsGroup = T.IsGroup,
	@IdType = T.IdTYpeATU
	 FROM TreeNSI_Addr_AddressesClassifierBY_LocalityProperty P
	 JOIN H ON H.Id = P.IdElement AND P.BeginDate = H.DD
	 JOIN @T T ON T.Id = P.LocalityTypeCode


	 IF @IsGroup IS NULL 
	 OR @Name IS NULL OR LEN(@Name)<= 1
	 OR @IdType IS NULL
		 BEGIN
			 --������ ��� �������� ����� ��� ������������
			 SET @IdATU = 0

			 SET @ErrorText = '�� ���������� ������ ��� �����!'
			 EXEC	[dbo].[usp_TreeNSI_serv_WriteErrorLog]	@isFatalError = 1, @text = @ErrorText,	@user = @user,	@directoryType = @directoryType, @idElement = NULL,	@ErrorSource = @IdProcedure, @Parameters = @parameters
		 
			 RETURN @IdATU
		 END

	 /************����������� ��������*****************/
	 --��������� ������ �� ��������
	 SET @ParentCode = CASE WHEN RIGHT(@Code,9) = REPLICATE('0',9) THEN NULL
	 WHEN RIGHT(@Code,6) = REPLICATE('0',6) THEN LEFT(@Code,1)+REPLICATE('0',9)
	 WHEN RIGHT(@Code,3) = REPLICATE('0',3) THEN LEFT(@Code,4)+REPLICATE('0',6)
	 ELSE LEFT(@Code,7)+REPLICATE('0',3) END

	 DECLARE @IsCenter BIT --�������, ��� ��� (���������� �����) �������� ���������������� ������� �������, ������, �/�, � ������ ��� ��������� ������ ���� �������� ��� "��������"
	 SET @IsCenter = (SELECT [dbo].[udf_TreeNSI_CheckATUCenterLocalityBY] (@IdClassifierLocality))

	 IF @IsCenter = 1 --��� ���������������� ������� �������� ����� � ����� ���������� ������
		 SET @ParentCode = CASE WHEN RIGHT(@ParentCode,9) = REPLICATE('0',9) THEN NULL
		 WHEN RIGHT(@ParentCode,6) = REPLICATE('0',6) THEN LEFT(@ParentCode,1)+REPLICATE('0',9)
		 WHEN RIGHT(@ParentCode,3) = REPLICATE('0',3) THEN LEFT(@ParentCode,4)+REPLICATE('0',6)
		 ELSE LEFT(@ParentCode,7)+REPLICATE('0',3) END


	 IF(@ParentCode IS NULL)
		 BEGIN
			 SET @ParentIdClassifierLocality = NULL --��� ��� ������� ��� �����
			 SET @ParentId = NULL
		 END
	 ELSE
		 BEGIN
			 
			 ;WITH H (Id,DD)
			AS
			(
			SELECT P.IdElement, MAX(P.BeginDate) FROM TreeNSI_Addr_AddressesClassifierBY_LocalityProperty P
			GROUP BY P.IdElement
			)
			SELECT 
			@ParentIdClassifierLocality = P.IdElement,
			@ParentName = LTRIM(P.Name),
			@ParentIdType = T.IdTYpeATU
			 FROM TreeNSI_Addr_AddressesClassifierBY_LocalityProperty P
			 JOIN H ON H.Id = P.IdElement AND P.BeginDate = H.DD
			 JOIN @T T ON T.Id = P.LocalityTypeCode
			 WHERE P.Code = @ParentCode

			 --�������� ������� �������� � ��
			SET @ParentId = (SELECT L.IdATU From TreeNSI_Addr_ATUCountryClassifierLocality L
			WHERE L.IdClassifier = 1 AND L.IdClassifierLocality = @ParentIdClassifierLocality)

			IF @ParentId IS NULL
			--����� ������� �������� (��������� ���� �� ���������)
			--�� �������� ��� ��������
				BEGIN
					--� ������ ����� ��������� ���� �� ����� ���, ��������� �������
					--

					SET @KolATU =(SELECT COUNT(*) FROM TreeNSI_Addr_AdministrativTerritorialUnit Un
					WHERE NOT EXISTS (SELECT * FROM TreeNSI_Addr_ATUCountryClassifierLocality L
					WHERE L.IdATU = Un.IdATU AND L.IdClassifier = 1)
					AND Un.IdCountry = 1 AND Un.IsGroup = 1 --�������� ������ ������� �������� (��� ����� ��������� ������, �� �� ����� ����, ��� ��� ��������-������������� ���� ����� ������� ���� � ����� ������
					AND LTRIM(Un.Name) = @ParentName)

					IF @KolATU > 1
						BEGIN
							--��� ������: ��� �� � �� ��������� �������� ��� �������� � ������������ �������� �������� �� ������ ����!
							
							SET @ParentId = NULL --�.�. � ���� ����� ������, �� ��� ������� ����� �������� �����!
							SET @ErrorText = '� �� ���������� ��������� ������������� � ����� ������� � ������������� ��� �����������: '+ RTRIM(@ParentName)
							 EXEC	[dbo].[usp_TreeNSI_serv_WriteErrorLog]	@isFatalError = 0, @text = @ErrorText,	@user = @user,	@directoryType = @directoryType, @idElement = NULL,	@ErrorSource = @IdProcedure, @Parameters = @parameters
						END
					IF @KolATU = 1 
						BEGIN
							--����� ���������� ������ �� ����� � ��������� ������
						
									SET @ParentId = (SELECT TOP 1 IdATU FROM TreeNSI_Addr_AdministrativTerritorialUnit Un
										WHERE NOT EXISTS (SELECT * FROM TreeNSI_Addr_ATUCountryClassifierLocality L
										WHERE L.IdATU = Un.IdATU AND L.IdClassifier = 1)
										AND Un.IdCountry = 1 AND Un.IsGroup = 1
										AND LTRIM(Un.Name) = @ParentName)

									--���������� ������ �� ��������� ������ �����

									UPDATE TreeNSI_Addr_AdministrativTerritorialUnit
									SET IsGroup = 1,
									Name = @ParentName,
									IdATUType = @ParentIdType,
									IdCountry = 1
									WHERE IdATU = @ParentId

									INSERT INTO TreeNSI_Addr_ATUCountryClassifierLocality
									(IdATU, IdClassifier, IdClassifierLocality)
									VALUES (@ParentId, 1, @ParentIdClassifierLocality)

									--��� ����������
									SET @ErrorText = '� �� ���������� ������������� � ����� ������ � ������������� ��� �����������: '+ RTRIM(@ParentName)+'. ������������ ���������� ������ �� ����� � ��������' 
									 EXEC	[dbo].[usp_TreeNSI_serv_WriteErrorLog]	@isFatalError = 0, @text = @ErrorText,	@user = @user,	@directoryType = @directoryType, @idElement = NULL,	@ErrorSource = @IdProcedure, @Parameters = @parameters

							
						END

					IF @KolATU = 0
						BEGIN
							--��������� �� ���� ��� ���������
							EXEC @ParentId = [dbo].[usp_TreeNSI_AddATUFromClassifierLocalityBY] @IdClassifierLocality = @ParentIdClassifierLocality

							IF @ParentId = 0
								SET @ParentId = NULL
						END

				END
			ELSE
				--�������� ������, ����� ��������
				BEGIN
					IF NOT EXISTS (SELECT * FROM TreeNSI_Addr_AdministrativTerritorialUnit Un
					WHERE Un.IdATU = @ParentId AND Un.IdATUType = @ParentIdType AND LTRIM(Un.Name) = @ParentName
					AND Un.IdCountry = 1
					AND Un.IsGroup = 1 )
						BEGIN
							--���������� ������ �� ��������� ������ �����
							UPDATE TreeNSI_Addr_AdministrativTerritorialUnit
							SET IsGroup = 1,
							Name = @ParentName,
							IdATUType = @ParentIdType,
							IdCountry = 1
							WHERE IdATU = @ParentId

							--��� ����������
							SET @ErrorText = '��� ������ � ����� ' + CAST(@ParentId AS varchar(10)) + ' ��������� ���������� (�������� ����� ��)'
							EXEC	[dbo].[usp_TreeNSI_serv_WriteErrorLog]	@isFatalError = 0, @text = @ErrorText,	@user = @user,	@directoryType = @directoryType, @idElement = NULL,	@ErrorSource = @IdProcedure, @Parameters = @parameters
						END

				END

		END

	 /************����� ����������� ��������*****************/

	 --��� �������� ��� ���������, ��� NULL

	--�������� �� ������� �� ������������ ���
	--���������� ������ ��� ��� ���������, ������� ����� ���� �������� ��� �������� ��������
	SET @KolATU = (SELECT COUNT(*) FROM TreeNSI_Addr_AdministrativTerritorialUnit Un
			--JOIN @T T ON T.IdTYpeATU = Un.IdATUType
			WHERE NOT EXISTS (SELECT * FROM TreeNSI_Addr_ATUCountryClassifierLocality L
			WHERE L.IdATU = Un.IdATU AND L.IdClassifier = 1)
			AND Un.IdCountry = 1 
			AND LTRIM(Un.Name) = @Name
			--AND (T.IsGroup = 1 OR T.IdTYpeATU = 13) --������������� ���� ����� ������� � �����
			AND Un.IdATUType IN (5,7,13)
			)

	IF @KolATU = 1 --���� ���������
		BEGIN
			SET @IdATU = (SELECT TOP 1 Un.IdATU FROM TreeNSI_Addr_AdministrativTerritorialUnit Un
				--JOIN @T T ON T.IdTYpeATU = Un.IdATUType
				WHERE NOT EXISTS (SELECT * FROM TreeNSI_Addr_ATUCountryClassifierLocality L
				WHERE L.IdATU = Un.IdATU AND L.IdClassifier = 1)
				AND Un.IdCountry = 1 
				AND LTRIM(Un.Name) = @Name
				--AND (T.IsGroup = 1 OR T.IdTYpeATU = 13) 
				AND Un.IdATUType IN (5,7,13)
				)

			UPDATE TreeNSI_Addr_AdministrativTerritorialUnit
			SET IdATUType = @IdType,
				IdCountry = 1,
				IsGroup = @IsGroup,
				ParentId = @ParentId,
				Name = @Name
			WHERE IdATU = @IdATU

			--��� ����������
			SET @ErrorText = '��������� ������ ��� �������� � ����� '+ CAST(@IdATU AS varchar(10))
			 EXEC	[dbo].[usp_TreeNSI_serv_WriteErrorLog]	@isFatalError = 0, @text = @ErrorText,	@user = @user,	@directoryType = @directoryType, @idElement = NULL,	@ErrorSource = @IdProcedure, @Parameters = @parameters
				
			INSERT INTO TreeNSI_Addr_ATUCountryClassifierLocality
					(IdATU, IdClassifier, IdClassifierLocality)
					VALUES (@IdATU, 1, @IdClassifierLocality)

		END

	IF @KolATU > 1
		BEGIN
			--���� ��������� ������������� � ����� ������� �������
			--��� �����

			--��� ������...
			SET @ErrorText = '� �� ���������� ��������� ������������� � ����� ������� � ��������� ������������� '+RTRIM(@Name)
			EXEC	[dbo].[usp_TreeNSI_serv_WriteErrorLog]	@isFatalError = 1, @text = @ErrorText,	@user = @user,	@directoryType = @directoryType, @idElement = NULL,	@ErrorSource = @IdProcedure, @Parameters = @parameters

			SET @IdATU = 0
			RETURN @IdATU

		END

	IF @KolATU = 0
		BEGIN

			--��������� �������� �� ����� �� �������������� � ���
			IF EXISTS (SELECT * FROM TreeNSI_Addr_ATUCountryClassifierLocality
			WHERE IdClassifier = 1 AND IdClassifierLocality = @IdClassifierLocality)
				BEGIN
					SET @IdATU = (SELECT IdATU FROM TreeNSI_Addr_ATUCountryClassifierLocality
					WHERE IdClassifier = 1 AND IdClassifierLocality = @IdClassifierLocality)

					RETURN @IdATU
				END


			INSERT INTO TreeNSI_Addr_AdministrativTerritorialUnit
			([IdCountry]
				,[IsGroup]
				,[ParentId]
				,[Name]
				,[IdATUType])
				VALUES
				(1
				,@IsGroup
				,@ParentId
				,@Name
				,@IdType)
		

			SET @IdATU = CAST(SCOPE_IDENTITY() AS INT)

			IF @IdATU IS NOT NULL
				INSERT INTO TreeNSI_Addr_ATUCountryClassifierLocality
				(IdATU, IdClassifier, IdClassifierLocality)
				VALUES (@IdATU, 1, @IdClassifierLocality)

			ELSE
				BEGIN
					--���-�� �����������
					SET @IdATU = 0

					--�����������
					SET @ErrorText = '�� ������� �������� ����� ��� (�� �����) '+ LEFT(ISNULL(ERROR_MESSAGE(),''),CASE WHEN LEN(ISNULL(ERROR_MESSAGE(),''))> 935 THEN 935 ELSE LEN(ISNULL(ERROR_MESSAGE(),'')) END)
					EXEC	[dbo].[usp_TreeNSI_serv_WriteErrorLog]	@isFatalError = 1, @text = @ErrorText,	@user = @user,	@directoryType = @directoryType, @idElement = NULL,	@ErrorSource = @IdProcedure, @Parameters = @parameters

				END


		END

	RETURN @IdATU

END

GO

DECLARE @result VARCHAR(10) = ' /FAIL'
IF(OBJECT_ID( N'usp_TreeNSI_AddATUFromClassifierLocalityBY') IS NOT NULL)
	SET @result = ' /OK'
print 'CREATE PROCEDURE [dbo].[usp_TreeNSI_AddATUFromClassifierLocalityBY]' + @result

/************* ���� �������� ����� *************/
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'���������� ������ ��� �� ��������� ������ ����� ��' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'usp_TreeNSI_AddATUFromClassifierLocalityBY'
GO
/************* ����� ����� �������� ����� *************/

IF(OBJECT_ID( N'usp_TreeNSI_AddATUBY') IS NOT NULL)
DROP PROCEDURE [dbo].[usp_TreeNSI_AddATUBY]
GO

--��������� ���������� ������ ��� ��� ��

CREATE PROCEDURE [dbo].[usp_TreeNSI_AddATUBY]
	(
	@ATUName VARCHAR(100),					--������������ ������ ���
	@ATUType INT = NULL ,					--��� ������ ���
	@IdClassifierLocality INT = NULL,		--��� ������ � ����������� ����� ��
	
	@LevelATUName0 VARCHAR(100) = NULL,		--������������ �������
	@LevelATUName1 VARCHAR(100) = NULL,		--������������ ������
	@LevelATUName2 VARCHAR(100) = NULL,		--������������ �/�

	@user INT = NULL						--��� ������������ TreeNSI
	)

AS
SET NOCOUNT ON
BEGIN
	
	DECLARE @IdATU INT --��������� ��� ��� (�� ������)
	SET @IdATU = 0 -- �������� �� ���������, ������� �������


	--��������� ���������--
	DECLARE @IdProcedure INT         --��������� ��� ���������
	SET @IdProcedure =  OBJECT_ID(N'dbo.usp_TreeNSI_AddATUBY')
	DECLARE @parameters XML          --������� ���������
	SET @parameters = (SELECT @ATUName AS 'ATUName', @ATUType AS 'ATUType', @IdClassifierLocality AS 'IdClassifierLocality', @LevelATUName0 AS 'LevelATUName0' , @LevelATUName1 AS 'LevelATUName1', @LevelATUName2 AS 'LevelATUName2', @user AS 'user' FOR XML RAW) 
	DECLARE @directoryType INT       --��� �����������
	SET @directoryType = NULL
	DECLARE @ErrorText VARCHAR(1000) --����� ������
	--***********************--
	SET @user = ISNULL(@user,(SELECT dbo.udf_TreeNSI_GetIdUser()))
	--������������, ������������ ��� ������ ������ ��� ��������. �������� ������� ������ ��������� ��������� ������, ����� ��� ������ ��������� ���� ����� ����� ������� ��������

	--������� ��������� ������
	DECLARE @Tab TABLE (id INT, Name VARCHAR(300), Code VARCHAR(10), LocTypeCode VARCHAR(3))
		
	--������� ������������� ���� ���
	DECLARE @T TABLE (Id VARCHAR(3), IdTYpeATU INT, IsGroup BIT)
	INSERT INTO @T
	(
	Id, IdTYpeATU, IsGroup )
	VALUES
	('101',5,1)
	,('102',7,1)
	,('103',11,1)
	,('111',13,0)
	,('112',13,0)
	,('113',13,0)
	,('121',61,0)
	,('122',15,0)
	,('123',17,0)
	--,('202',null,0) --��������������� �����
	,('213',13,0)
	,('221',61,0)
	,('222',15,0)
	,('223',17,0)
	,('231',25,0)
	,('232',29,0)
	,('233',30,0)
	,('234',53,0)
	,('235',60,0)
	--,('239',null,0) --����			

	IF @IdClassifierLocality IS NOT NULL
		BEGIN
		
			--���� ������ �� �����.

			EXEC @IdATU = dbo.usp_TreeNSI_AddATUFromClassifierLocalityBY @IdClassifierLocality = @IdClassifierLocality

			RETURN @IdATU 
	END

	IF LEN(RTRIM(@ATUName)) < 2
		BEGIN
			--����� ����
			SET @ErrorText = '������������ ������ ��� ����� ������: ����� ������������'
			EXEC	[dbo].[usp_TreeNSI_serv_WriteErrorLog]	@isFatalError = 1, @text = @ErrorText,	@user = @user,	@directoryType = @directoryType, @idElement = NULL,	@ErrorSource = @IdProcedure, @Parameters = @parameters

			SET @IdATU = 0
			RETURN @IdATU

		END

	--��������� ������� ������� 
	;WITH dat (id, DD)
	AS
	(
	SELECT IdElement, MAX(BeginDate) FROM TreeNSI_Addr_AddressesClassifierBY_LocalityProperty
	GROUP BY IdElement
	)
	, SS (idProp, Code, IdElement, Name)
	AS
	(
	SELECT pr.IdProperty, pr.Code, pr.IdElement, pr.Name FROM TreeNSI_Addr_AddressesClassifierBY_LocalityProperty pr
	JOIN dat ON dat.id = pr.IdElement AND dat.DD = pr.BeginDate
	WHERE pr.LocalityTypeCode = '103'
	)
	, sel (id, Code, Name, LocType, LocTypeCode, pr1, pr2, pr3)
	AS
	(
	SELECT prop.IdElement, prop.Code, prop.Name, prop.LocalityType, prop.LocalityTypeCode--prop.*, SS.Code, SS.Name 
	, pr1 = case WHEN prop.DistrictName = @LevelATUName0 AND @LevelATUName0 IS NOT NULL THEN 1 ELSE 0 END
	, pr2 = case WHEN prop.RegionName = @LevelATUName1 AND @LevelATUName1 IS NOT NULL THEN 1 ELSE 0 END
	, pr3 = case WHEN SS.Name = @LevelATUName2 AND @LevelATUName2 IS NOT NULL THEN 1 ELSE 0 END

	FROM TreeNSI_Addr_AddressesClassifierBY_LocalityProperty prop
	JOIN dat ON dat.id = prop.IdElement AND dat.DD = prop.BeginDate
	LEFT JOIN SS ON SS.idProp != prop.IdProperty AND LEFT(SS.Code,7) = LEFT(prop.Code,7)
	WHERE prop.EndDate IS NULL
	AND prop.Name = @ATUName
	)
	INSERT INTO @Tab
	SELECT sel.id, sel.Name, sel.Code, sel.LocTypeCode FROM sel
	WHERE pr1+pr2+pr3 = (SELECT MAX(pr1+pr2+pr3) FROM sel)

	DECLARE @count INT --���������� ���������� �������
	SET @count = (SELECT COUNT(*) FROM @Tab)

	--������ �� �������
	IF @count = 0 
		BEGIN 
			--� ����������� �� ������� ������������ ����������� ������� � �������� �������
			--���� ��� ���������
			SET @ErrorText = '� ����� ������ ��� �� �������!'
			EXEC	[dbo].[usp_TreeNSI_serv_WriteErrorLog]	@isFatalError = 1, @text = @ErrorText,	@user = @user,	@directoryType = @directoryType, @idElement = NULL,	@ErrorSource = @IdProcedure, @Parameters = @parameters


			SET @IdATU = 0
			RETURN @IdATU
		END

	--������� ��������� �������� �������
	IF @count > 1 
		BEGIN
			--������� �������� ������ ����� ��� ���
			SET @count = (SELECT COUNT(*) FROM @Tab da
			JOIN @T t ON t.Id = da.LocTypeCode
			WHERE 1 = CASE WHEN @ATUType IS NULL THEN 1 ELSE CASE WHEN t.IdTYpeATU = @ATUType THEN 1 ELSE 0 END END)

			IF @count != 1 
					BEGIN
						--���������� ����������� �� ��������. ����� ��������� �����
						--���
						SET @ErrorText = '� ����� ��� � ����� ������������� ������� ���������!'
						EXEC	[dbo].[usp_TreeNSI_serv_WriteErrorLog]	@isFatalError = 1, @text = @ErrorText,	@user = @user,	@directoryType = @directoryType, @idElement = NULL,	@ErrorSource = @IdProcedure, @Parameters = @parameters

						SET @IdATU = 0
						RETURN @IdATU

					END
		ELSE
			--��������� ���� ��� ������� ��������� ����������� ������
			BEGIN
				SET @IdClassifierLocality = (SELECT da.id FROM @Tab da
				JOIN @T t ON t.Id = da.LocTypeCode
				WHERE 1 = CASE WHEN @ATUType IS NULL THEN 1 ELSE CASE WHEN t.IdTYpeATU = @ATUType THEN 1 ELSE 0 END END)

				--����� ���� ���������� ���������
				--����������� ��������� usp_TreeNSI_AddATUFromClassifierLocalityBY
				EXEC @IdATU = dbo.usp_TreeNSI_AddATUFromClassifierLocalityBY @IdClassifierLocality = @IdClassifierLocality
	
				RETURN @IdATU

			END

		END

	--���������� ������� ���� ������
	ELSE --IF @count = 1
		BEGIN
			SET @IdClassifierLocality = (SELECT TOP 1 id FROM @Tab)

			--����� ���� ���������� ���������
			--����������� ��������� usp_TreeNSI_AddATUFromClassifierLocalityBY
			EXEC @IdATU = dbo.usp_TreeNSI_AddATUFromClassifierLocalityBY @IdClassifierLocality = @IdClassifierLocality
	 
			RETURN @IdATU

		END

	RETURN @IdATU

END

DECLARE @result VARCHAR(10) = ' /FAIL'
IF(OBJECT_ID( N'usp_TreeNSI_AddATUBY') IS NOT NULL)
	SET @result = ' /OK'
print 'CREATE PROCEDURE [dbo].[usp_TreeNSI_AddATUBY]' + @result

/************* ���� �������� ����� *************/
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'���������� ������ ��� ��� ���������� ��������' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'usp_TreeNSI_AddATUBY'
GO
/************* ����� ����� �������� ����� *************/

IF(OBJECT_ID( N'usp_TreeNSI_AddATU') IS NOT NULL)
DROP PROCEDURE [dbo].[usp_TreeNSI_AddATU]
GO

--��������� ���������� ������ ���

CREATE PROCEDURE [dbo].[usp_TreeNSI_AddATU]
	(
	@IdCountry INT,							--������ ������ ���
	@ATUName VARCHAR(100),					--������������ ������ ���
	@ATUType INT,							--��� ������ ���
	@LevelsATUData NVARCHAR(1000) = NULL,	-- ������ � ���� ������� ������� --RAW('LevelATU'), ROOT('LevelsATU')
											--<LevelsATU>
											--	<LevelATU
											--		IdLevel = "..." INT NOT NULL -- ������� � 0 ������� ���������� (��� ��: 0- �������, 1- �����, 2- �/�)
											--		IdATU = "..." INT --��� ��� ��������� ��� 
											--		Name = "..." VARCHAR(100) --������������ N-������
											--		IdATUType = "..." INT --��� ���� ���
											--	/>
											--	...
											--	</LevelsATU>

	@user INT = NULL						--��� ������������ TreeNSI
	)

AS
SET NOCOUNT ON
BEGIN
	
	DECLARE @IdATU INT --��������� ��� ��� (�� ������)
	SET @IdATU = 0 -- �������� �� ���������, ������� �������


	--��������� ���������--
	DECLARE @IdProcedure INT         --��������� ��� ���������
	SET @IdProcedure =  OBJECT_ID(N'dbo.usp_TreeNSI_AddATU')
	DECLARE @parameters XML          --������� ���������
	SET @parameters = (SELECT @IdCountry AS 'IdCountry', @ATUName AS 'ATUName', @ATUType AS 'ATUType', @LevelsATUData AS 'LevelsATUData', @user AS 'user' FOR XML RAW) 
	DECLARE @directoryType INT       --��� �����������
	SET @directoryType = NULL
	DECLARE @ErrorText VARCHAR(1000) --����� ������
	--***********************--
	SET @user = ISNULL(@user,(SELECT dbo.udf_TreeNSI_GetIdUser()))
	--������������, ������������ ��� ������ ������ ��� ��������. �������� ������� ������ ��������� ��������� ������, ����� ��� ������ ��������� ���� ����� ����� ������� ��������

	/*********************��������� ��������*********************/

	IF @IdCountry IS NULL
		BEGIN
			--������ �����������
			--���
			SET @ErrorText = '������������ ������ ��� ����� ������: ��������� ������!'
			EXEC	[dbo].[usp_TreeNSI_serv_WriteErrorLog]	@isFatalError = 1, @text = @ErrorText,	@user = @user,	@directoryType = @directoryType, @idElement = NULL,	@ErrorSource = @IdProcedure, @Parameters = @parameters

			SET @IdATU = 0
			RETURN @IdATU

		END

	IF LEN(ISNULL(@ATUName,'')) = 0
		BEGIN
			--������������ �����������
			--���
			SET @ErrorText = '������������ ������ ��� ����� ������: ����������� ������������!'
			EXEC	[dbo].[usp_TreeNSI_serv_WriteErrorLog]	@isFatalError = 1, @text = @ErrorText,	@user = @user,	@directoryType = @directoryType, @idElement = NULL,	@ErrorSource = @IdProcedure, @Parameters = @parameters

			SET @IdATU = 0
			RETURN @IdATU

		END

	IF @ATUType IS NOT NULL AND NOT EXISTS (SELECT * FROM TreeNSI_Addr_AdministrativTerritorialUnitType WHERE IdATUType = @ATUType)
		BEGIN
			--������ ��� ��� (������ ���� ����� ���������!)
			--���
			SET @ErrorText = '������������ ������ ��� ����� ������: ��������� ��� ��� ����������� � ��!'
			EXEC	[dbo].[usp_TreeNSI_serv_WriteErrorLog]	@isFatalError = 1, @text = @ErrorText,	@user = @user,	@directoryType = @directoryType, @idElement = NULL,	@ErrorSource = @IdProcedure, @Parameters = @parameters

			SET @IdATU = 0
			RETURN @IdATU

		END

	IF @IdCountry NOT IN (1,2) AND @ATUType IS NULL
		BEGIN
			--��� ��� ���������� ��� ���� �����, ����� ���, � ������� ���� � �� ������������ ������ �������
			--���
			SET @ErrorText = '������������ ������ ��� ����� ������: ����������� ��� ���!'
			EXEC	[dbo].[usp_TreeNSI_serv_WriteErrorLog]	@isFatalError = 1, @text = @ErrorText,	@user = @user,	@directoryType = @directoryType, @idElement = NULL,	@ErrorSource = @IdProcedure, @Parameters = @parameters

			SET @IdATU = 0
			RETURN @IdATU

		END
	/*********************����� ��������� ��������*********************/

	--������� ��� ������ � ������� ����������
	DECLARE @t TABLE(id INT IDENTITY(1,1) ,idLevel INT, IdATU INT, Name VARCHAR(100), IdType INT)	

	--�������� ������� ��� ������ � TRY
	IF LEN(ISNULL(@LevelsATUData,'')) > 10
		BEGIN
			DECLARE @idXmlDocuments INT
			EXEC sp_xml_preparedocument @idXmlDocuments OUTPUT, @LevelsATUData 
		
			INSERT INTO @t		
			SELECT 
				Id,
				IdATU,
				Name,
				IdType
			FROM
				OPENXML (@idXmlDocuments, '/LevelsATU/LevelATU') WITH 
				(
					Id INT '@IdLevel',
					IdATU INT '@IdATU',
					Name NVARCHAR(100) '@Name',
					IdType INT '@IdATUType'
				)
				ORDER BY Id
			EXEC sp_xml_removedocument @idXmlDocuments
		END

	--��������� ����������
	DECLARE @x INT, @y INT, @Name VARCHAR(100)

	--������ �� �������
	IF @IdCountry = 1 --��

		BEGIN

			DECLARE @_lev0 VARCHAR(100), @_lev1 VARCHAR(100), @_lev2 VARCHAR(100)

			SET @x = 1
			SET @y = (SELECT MAX(id) FROM @t)

			WHILE @x<=@y
				BEGIN

					IF @x = 1 
					SET @_lev0 = (SELECT Name FROM @t WHERE id = @x)
					ELSE IF @x = 2 
					SET @_lev1 = (SELECT Name FROM @t WHERE id = @x)
					ELSE IF @x = 3 
					SET @_lev2 = (SELECT Name FROM @t WHERE id = @x)

					SET @x = @x + 1

				END

			EXEC @IdATU = dbo.usp_TreeNSI_AddATUBY @ATUName = @ATUName, @ATUType = @ATUType, @IdClassifierLocality = null, @LevelATUName0 = @_lev0, @LevelATUName1 = @_lev1, @LevelATUName2 = @_lev2, @user = @user

			RETURN @IdATU

		END

	ELSE IF @IdCountry = 2 --��
		BEGIN
			--����� ��������� ���������� ���������� ���
			SET @IdATU = 0 --����
			RETURN @IdATU
		END

	ELSE --��� ��������� ������
		BEGIN

			DECLARE @tab TABLE (id INT IDENTITY(1,1), IdATU INT, Name VARCHAR(100), IdType INT)

			--������� ������� ������������ �� ������������ ���������� (��������� ���������� �� �� ������ ��� ���������)
			--���� �� �� �����, �� �� ������� ��� ���� ���
			--��� ���������� �������, ���������� �� ���� ���, ��������� ��� ���������� ���������� ������� �������� ������ � @LevelsATUData


			--;WITH defDD (IdC, dd)
			--AS
			--(SELECT IdCountry, MAX(BeginDate) FROM TreeNSI_Addr_CountryAddressSettings
			--WHERE IdAddressType IS NULL
			--GROUP BY IdCountry)
			--, def (Id)
			--AS
			--(SELECT * FROM TreeNSI_Addr_CountryAddressSettings S
			--JOIN defDD WHERE S.IdCountry = 


			--SELECT * FROM @t t
			--JOIN TreeNSI_Addr_AdministrativTerritorialUnitType AType ON AType.IdATUType = t.IdATU
			--LEFT JOIN TreeNSI_Addr_CountryAddressSettings Sett ON Sett.IdCountry = @IdCountry AND Sett.IdAddressType = 1 AND
			--LEFT JOIN TreeNSI_Addr_CountryAddressSettingsOrderData SetOrd ON SetOrd.IdATUType = t.IdATU

			--����� ���������� ������ �� ��������� ����� ���, � @tab ��������� � ��� ������� ������� 
			--����� ���� ������� ��������� �� �������� �� ���������� ������� ��������� 
			--���� IdATU �� ����� �� ���������� ����� ���������� ��� ����������
			--���� � ���������� ��� ������ ���� ������� �������� ���������. �� �� �� ������ �������� ����� ������� ����������
			--���� �� ������� ����������, �� ������ ������ ��������� ��� ���

			RETURN @IdATU

			--

		END

	RETURN @IdATU

END

GO

DECLARE @result VARCHAR(10) = ' /FAIL'
IF(OBJECT_ID( N'usp_TreeNSI_AddATU') IS NOT NULL)
	SET @result = ' /OK'
print 'CREATE PROCEDURE [dbo].[usp_TreeNSI_AddATU]' + @result

/************* ���� �������� ����� *************/
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'���������� ������ ���' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'usp_TreeNSI_AddATU'
GO
/************* ����� ����� �������� ����� *************/

IF(OBJECT_ID( N'usp_TreeNSI_AddAddress') IS NOT NULL)
DROP PROCEDURE [dbo].[usp_TreeNSI_AddAddress]
GO

--��������� ���������� ������

CREATE PROCEDURE [dbo].[usp_TreeNSI_AddAddress]
	(
	@IdCountry INT,							--������ ������ ���

	@ATUAddress VARCHAR(100)= NULL,			--����� ���������� ������� � �������� ���
	@PostCode VARCHAR(20) = NULL,			--�������� ������ (�������� ��������� ���������)

	@IdATU INT = NULL,						--������������� ��� TreeNSI

	@IdClassifierLocality INT = NULL,		--������������� ��� �� ����������� ������������� �������������� ���

	@ATUName VARCHAR(100),					--������������ ��� 
	@ATUType INT,							--��� ���
	@LevelsATUData NVARCHAR(1000) = NULL,	-- ������ � ���� ������� ������� --RAW('LevelATU'), ROOT('LevelsATU')
											--<LevelsATU>
											--	<LevelATU
											--		IdLevel = "..." INT NOT NULL -- ������� � 0 ������� ���������� (��� ��: 0- �������, 1- �����, 2- �/�)
											--		IdATU = "..." INT --��� ��� ��������� ��� 
											--		Name = "..." VARCHAR(100) --������������ N-������
											--		IdATUType = "..." INT --��� ���� ���
											--	/>
											--	...
											--	</LevelsATU>

	@ExtraInfo VARCHAR(100) = NULL,			--�������������� �������� (����� ��������, ������� 2 ���� � �.�.)

	@user INT = NULL						--��� ������������ TreeNSI
	)

AS
SET NOCOUNT ON
BEGIN
	
	DECLARE @IdAddress INT --��������� ��� ������ �� ������
	SET @IdAddress = 0 -- �������� �� ���������, ������� �������


	--��������� ���������--
	DECLARE @IdProcedure INT         --��������� ��� ���������
	SET @IdProcedure =  OBJECT_ID(N'dbo.usp_TreeNSI_AddAddress')
	DECLARE @parameters XML          --������� ���������
	SET @parameters = (SELECT @IdCountry AS 'IdCountry', @ATUAddress AS '@ATUAddress', @PostCode AS 'PostCode', @IdATU AS 'IdATU', @IdClassifierLocality AS 'IdClassifierLocality', @ATUName AS 'ATUName', @ATUType AS 'ATUType', @LevelsATUData AS 'LevelsATUData',@ExtraInfo AS 'ExtraInfo', @user AS 'user' FOR XML RAW) 
	DECLARE @directoryType INT       --��� �����������
	SET @directoryType = NULL
	DECLARE @ErrorText VARCHAR(1000) --����� ������
	--***********************--
	SET @user = ISNULL(@user,(SELECT dbo.udf_TreeNSI_GetIdUser()))
	--������������, ������������ ��� ������ ������ ��� ��������. �������� ������� ������ ��������� ��������� ������, ����� ��� ������ ��������� ���� ����� ����� ������� ��������

	/*********************��������� ��������*********************/

	IF @IdCountry IS NULL
		BEGIN
			--������ �����������
			--���
			SET @ErrorText = '������������ ������ ��� ����� ������: ��������� ������!'
			EXEC	[dbo].[usp_TreeNSI_serv_WriteErrorLog]	@isFatalError = 1, @text = @ErrorText,	@user = @user,	@directoryType = @directoryType, @idElement = NULL,	@ErrorSource = @IdProcedure, @Parameters = @parameters

			SET @IdAddress = 0
			RETURN @IdAddress

		END

	IF @IdATU IS NULL AND @IdClassifierLocality IS NULL AND LEN(ISNULL(@ATUName,'')) < 2 AND @ATUType IS NULL 
		BEGIN
			--��� ������ �� ���
			--���
			SET @ErrorText = '������������ ������ ��� ����� ������: ��� ������ �� ���!'
			EXEC	[dbo].[usp_TreeNSI_serv_WriteErrorLog]	@isFatalError = 1, @text = @ErrorText,	@user = @user,	@directoryType = @directoryType, @idElement = NULL,	@ErrorSource = @IdProcedure, @Parameters = @parameters

			SET @IdAddress = 0
			RETURN @IdAddress

		END
	/*********************����� ��������� ��������*********************/

	/*********************��������� ����������**********************/
	DECLARE @sqlText NVARCHAR(max), @_return INT

	IF @IdATU IS NULL
		BEGIN --����������� ���

			IF @IdClassifierLocality IS NOT NULL 
				BEGIN
					--�������� ������� ��������������
					IF NOT EXISTS (SELECT * FROM TreeNSI_Addr_CountryAddressesClassifierLocality WHERE IdCountry = @IdCountry)
						BEGIN
							--��� ��������� ������ �� ������������ �������������, ��� ������ ��������� ������ �� ��������� ������������ �������������
							--���
							SET @ErrorText = '����������� ���: ��� ��������� ������ �� ������������ �������������, ��� ������ ��������� ������ �� ��������� ������������ �������������!'
							EXEC	[dbo].[usp_TreeNSI_serv_WriteErrorLog]	@isFatalError = 1, @text = @ErrorText,	@user = @user,	@directoryType = @directoryType, @idElement = NULL,	@ErrorSource = @IdProcedure, @Parameters = @parameters

							SET @IdAddress = 0
							RETURN @IdAddress

						END


				--�������� ������������� �������� ������ � ������������ ��������������
				SET @_return = 0
				SET @sqlText = N'SELECT @return = COUNT(*) FROM '+ (SELECT TOP 1 TableName FROM TreeNSI_Addr_CountryAddressesClassifierLocality WHERE IdCountry = @IdCountry)
				+ ' WHERE ' + (SELECT TOP 1 KeyFieldName FROM TreeNSI_Addr_CountryAddressesClassifierLocality WHERE IdCountry = @IdCountry) 
				+ ' = @id'

				EXECUTE sp_executesql @sqlText, N'@return INT OUTPUT, @id INT', @return = @_return OUTPUT ,@id = @IdClassifierLocality

				IF @_return = 0
					BEGIN
							--��� ��������� ������ �� ������������ �������������, � ������������ �������������� ��������� ������ �� ����������
							--���
							SET @ErrorText = '����������� ���: ��� ��������� ������ �� ������������ �������������, � ������������ �������������� ��������� ������ �� ����������!'
							EXEC	[dbo].[usp_TreeNSI_serv_WriteErrorLog]	@isFatalError = 1, @text = @ErrorText,	@user = @user,	@directoryType = @directoryType, @idElement = NULL,	@ErrorSource = @IdProcedure, @Parameters = @parameters

							SET @IdAddress = 0
							RETURN @IdAddress

					END

				--� ����������� �� ������ �������� ������� �������� @IdATU
				IF @IdCountry = 1 -- ��
					BEGIN

						EXEC @IdATU = [dbo].[usp_TreeNSI_AddATUFromClassifierLocalityBY] @IdClassifierLocality

					END

				--����� �������� �� ���������� ���
				IF @IdATU = 0
					BEGIN
							--�� �������� � ������������ ��������������� �� ������� ���������� ���
							--���
							SET @ErrorText = '����������� ���: ��� ��������� ������ �� ������������ �������������, ���������� ���������� ��� ���������!'
							EXEC	[dbo].[usp_TreeNSI_serv_WriteErrorLog]	@isFatalError = 1, @text = @ErrorText,	@user = @user,	@directoryType = @directoryType, @idElement = NULL,	@ErrorSource = @IdProcedure, @Parameters = @parameters

							SET @IdAddress = 0
							RETURN @IdAddress

					END

				END 
	
			ELSE
				BEGIN
					IF @ATUType IS NULL 
						BEGIN
							--��� ������ �� ���
							--���
							SET @ErrorText = '������������ ������ ��� ����� ������: �������� ��� ���!'
							EXEC	[dbo].[usp_TreeNSI_serv_WriteErrorLog]	@isFatalError = 1, @text = @ErrorText,	@user = @user,	@directoryType = @directoryType, @idElement = NULL,	@ErrorSource = @IdProcedure, @Parameters = @parameters

							SET @IdAddress = 0
							RETURN @IdAddress

						END

					IF @ATUName IS NULL 
						BEGIN
							--��� ������ �� ���
							--���
							SET @ErrorText = '������������ ������ ��� ����� ������: ��������� ������������ ���!'
							EXEC	[dbo].[usp_TreeNSI_serv_WriteErrorLog]	@isFatalError = 1, @text = @ErrorText,	@user = @user,	@directoryType = @directoryType, @idElement = NULL,	@ErrorSource = @IdProcedure, @Parameters = @parameters

							SET @IdAddress = 0
							RETURN @IdAddress

						END

					--������� �������� (����������) ��� �� ������������ � ����...

					EXEC @IdATU = [dbo].[usp_TreeNSI_AddATU] @IdCountry, @ATUName, @ATUType, @LevelsATUData, @user

					--����� �������� �� ���������� ���
					IF @IdATU = 0
						BEGIN
								--�� ������������ � ���� ���������� ��� �� �������
								--���
								SET @ErrorText = '����������� ���: �� ������������ � ���� ���������� ��� ���������!'
								EXEC	[dbo].[usp_TreeNSI_serv_WriteErrorLog]	@isFatalError = 1, @text = @ErrorText,	@user = @user,	@directoryType = @directoryType, @idElement = NULL,	@ErrorSource = @IdProcedure, @Parameters = @parameters

								SET @IdAddress = 0
								RETURN @IdAddress

						END

				END
		END --����� ����������� ���

	--��� ������ ���� ��������� � ������� �������

	--1. �������� ������, ����� ����� ����� ��� ����
	IF EXISTS (SELECT * FROM TreeNSI_Addr_Address
	WHERE IdCountry = @IdCountry
	AND IdATU = @IdATU
	AND REPLACE(ISNULL([dbo].[udf_TreeNSI_ATUAddressTrim](@IdCountry,@IdATU,@ATUAddress),'')+'^'+RTRIM(ISNULL(@PostCode,''))+'^'+ISNULL([dbo].[udf_TreeNSI_ATUAddressTrim](@IdCountry,@IdATU,@ExtraInfo),''),' ','')
	= REPLACE(ISNULL([dbo].[udf_TreeNSI_ATUAddressTrim](@IdCountry,@IdATU,ATUAddress),'')+'^'+RTRIM(ISNULL(PostCode,''))+'^'+ISNULL([dbo].[udf_TreeNSI_ATUAddressTrim](@IdCountry,@IdATU,ExtraInfo),''),' ','')
	)
		BEGIN
			--��� ���������� ������
			--���
			SET @ErrorText = '� �� ��� ���������� �������� �����'
			EXEC	[dbo].[usp_TreeNSI_serv_WriteErrorLog]	@isFatalError = 0, @text = @ErrorText,	@user = @user,	@directoryType = @directoryType, @idElement = NULL,	@ErrorSource = @IdProcedure, @Parameters = @parameters

			SET @IdAddress = (SELECT TOP 1 IdAddress FROM TreeNSI_Addr_Address
								WHERE IdCountry = @IdCountry
								AND IdATU = @IdATU
								AND REPLACE(ISNULL([dbo].[udf_TreeNSI_ATUAddressTrim](@IdCountry,@IdATU,@ATUAddress),'')+'^'+RTRIM(ISNULL(@PostCode,''))+'^'+ISNULL([dbo].[udf_TreeNSI_ATUAddressTrim](@IdCountry,@IdATU,@ExtraInfo),''),' ','')
								= REPLACE(ISNULL([dbo].[udf_TreeNSI_ATUAddressTrim](@IdCountry,@IdATU,ATUAddress),'')+'^'+RTRIM(ISNULL(PostCode,''))+'^'+ISNULL([dbo].[udf_TreeNSI_ATUAddressTrim](@IdCountry,@IdATU,ExtraInfo),''),' ','')
								ORDER BY IsActive DESC)
			RETURN @IdAddress

		END

	--������� ��������
	INSERT INTO TreeNSI_Addr_Address
			([IdCountry]
				,[IdATU]
				,[ATUAddress]
				,[PostCode]
				,[ExtraInfo]
				,[IsActive])
				VALUES
				(@IdCountry
				,@IdATU
				,[dbo].[udf_TreeNSI_ATUAddressTrim](@IdCountry,@IdATU,@ATUAddress)
				,@PostCode
				,[dbo].[udf_TreeNSI_ATUAddressTrim](@IdCountry,@IdATU,@ExtraInfo)
				,1)
		

	SET @IdAddress = CAST(SCOPE_IDENTITY() AS INT)

	IF @IdAddress IS NULL
		BEGIN
			--���-�� �����������
			SET @IdAddress = 0

			--�����������
			SET @ErrorText = '�� ������� �������� ����� ����� '+ LEFT(ISNULL(ERROR_MESSAGE(),''),CASE WHEN LEN(ISNULL(ERROR_MESSAGE(),''))> 935 THEN 935 ELSE LEN(ISNULL(ERROR_MESSAGE(),'')) END)
			EXEC	[dbo].[usp_TreeNSI_serv_WriteErrorLog]	@isFatalError = 1, @text = @ErrorText,	@user = @user,	@directoryType = @directoryType, @idElement = NULL,	@ErrorSource = @IdProcedure, @Parameters = @parameters

		END

	RETURN @IdAddress


END
GO

DECLARE @result VARCHAR(10) = ' /FAIL'
IF(OBJECT_ID( N'usp_TreeNSI_AddAddress') IS NOT NULL)
	SET @result = ' /OK'
print 'CREATE PROCEDURE [dbo].[usp_TreeNSI_AddAddress]' + @result

/************* ���� �������� ����� *************/
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'���������� ������ ������' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'usp_TreeNSI_AddAddress'
GO
/************* ����� ����� �������� ����� *************/

print 'END InsertAddressHelper ' + CONVERT(VARCHAR(50) ,GetDATE(), 113 )

