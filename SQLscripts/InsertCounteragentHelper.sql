USE [TreeNSI_test]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/****************************************************************/
/****************************************************************/
/**           Helper ��� ����� ������ �����������              **/
/****************************************************************/
/****************************************************************/

--***************************************************************--
--**  ��� ���������� ������ ����������, ����� COLLATE � �����  **--
--**       ������ ���� ����� ��, ��� ��� �� � �����!!!         **--
--***************************************************************--

--***************************************************************--
--**   ��� ���������� ������ ��������� ����������� ����������  **--
--**                    TreeNSI_Country                        **--
--***************************************************************--


print 'BEGIN InsertCounteragentHelper ' + CONVERT(VARCHAR(50) ,GetDATE(), 113 )

DECLARE @need INT = 1
IF(OBJECT_ID( N'TreeNSI_serv_CouteragentNamePrefix') IS NOT NULL)
	BEGIN
		SET @need = -1
		IF((SELECT COUNT(*) FROM TreeNSI_serv_CouteragentNamePrefix) > 0)
			SET @need = 0
	END
IF(@need < 0)
	DROP TABLE [dbo].[TreeNSI_serv_CouteragentNamePrefix]
GO

IF(OBJECT_ID( N'TreeNSI_serv_CouteragentNamePrefix') IS NULL)
BEGIN
	CREATE TABLE [dbo].[TreeNSI_serv_CouteragentNamePrefix](
		[word] [varchar](50) NULL,
		[IdTreeNSICountry] [int] NULL
	) ON [PRIMARY]

	DECLARE @result VARCHAR(10) = ' /FAIL'
	IF(OBJECT_ID( N'TreeNSI_serv_CouteragentNamePrefix') IS NOT NULL)
		SET @result = ' /OK'
	print 'CREATE PROCEDURE [dbo].[TreeNSI_serv_CouteragentNamePrefix]' + @result
	print '��� �������������� ������ ���������� ��������� ������� TreeNSI_serv_CouteragentNamePrefix!'
END
GO

IF(OBJECT_ID( N'udf_TreeNSI_GetCouteragentShortName') IS NOT NULL)
DROP FUNCTION [dbo].[udf_TreeNSI_GetCouteragentShortName]
GO

--������� ��������� ������� ������������ ��� �����������

CREATE FUNCTION [dbo].[udf_TreeNSI_GetCouteragentShortName]
(
@fullName VARCHAR(200)
,@idCountry INT
)
RETURNS VARCHAR(100)
AS
BEGIN
	DECLARE @shortName VARCHAR(250)
	SET @shortName = ''

	SET @fullName = REPLACE(@fullName,'"',' ')

	SET @fullName = REPLACE(
					REPLACE(
					REPLACE(
					REPLACE(
					REPLACE(
					REPLACE(
					REPLACE(
					REPLACE(
					REPLACE(
					REPLACE(
					REPLACE(
					REPLACE(
					REPLACE(
					REPLACE(
					REPLACE(
					REPLACE(REPLACE(REPLACE(REPLACE(ISNULL(@fullName,''),'  ',' '),'���"','��� '),'���"','��� '),'���"','��� ')
					,'��� �� �������� �����','')
					,'������� ��������� ����������� �� �������� �����','')
					,'��������� ����������� �� �������� �����','')
					,'��� �� �������� �����','')
					,'�������� � ������������ ����������������','')
					,'�������� � �������������� ����������������','')
					,'�������� ����������� ��������','')
					,'���������� �������� ����������� ��������','')
					,'������� �������� ����������� ��������','')
					,'��������� ���������� �������� ����������� ��������','')
					,'�������� ����������� ��������','')
					,'����������� ��������','')
					,'�� �� �������� �����','')
					,'������� �����������','')
					,'�-�','������')

	IF LEN(RTRIM(@fullName)) = 0 
		RETURN @shortName

	;
	WITH w (id, word, ost)
	AS
	(SELECT 1 , 
	CASE WHEN CHARINDEX(' ',RTRIM(LTRIM(@fullName))) = 0 THEN RTRIM(LTRIM(@fullName)) ELSE 
	RTRIM(LEFT(Ltrim(@fullName),CHARINDEX(' ',LTRIM(RTRIM(@fullName)),1))) END,
	CASE WHEN CHARINDEX(' ',RTRIM(LTRIM(@fullName))) = 0 THEN NULL ELSE
	 LTRIM(SUBSTRING(LTRIM(RTRIM(@fullName)),CHARINDEX(' ',LTRIM(RTRIM(@fullName)),1),LEN(LTRIM(RTRIM(@fullName)))- CHARINDEX(' ',LTRIM(RTRIM(@fullName)),1)+1)) END
	UNION ALL
	SELECT id+1, CASE WHEN CHARINDEX(' ',LTRIM(RTRIM(ost)),1) = 0 THEN ost ELSE RTRIM(left(Ltrim(ost),CHARINDEX(' ',LTRIM(RTRIM(ost)),1))) END,
	CASE WHEN CHARINDEX(' ',LTRIM(RTRIM(ost)),1) = 0 THEN NULL ELSE LTRIM(SUBSTRING(LTRIM(RTRIM(ost)),CHARINDEX(' ',LTRIM(RTRIM(ost)),1),LEN(LTRIM(RTRIM(ost)))- CHARINDEX(' ',LTRIM(RTRIM(ost)),1)+1)) END FROM w
	WHERE OST IS NOT NULL
	)
	,ss
	(short, poz)
	AS
	(
	SELECT CASE WHEN 
	EXISTS (SELECT * FROM serv_CouteragentNamePrefix pr WHERE pr.word = w.word AND pr.IdTreeNSICountry = @idCountry
	--���������� 
	AND 1 = CASE WHEN w.word = '�-�' AND (SELECT COUNT(*) FROM w )> 2 THEN 0 ELSE 1 END
	)
	THEN CAST('' AS VARCHAR(200))
	ELSE
	CAST(w.word AS VARCHAR(200))
	END
	, w.id FROM w 
	WHERE w.id = 1
	UNION all
	SELECT CAST(ISNULL(ss.short,'') 
	+CASE WHEN 
	EXISTS (SELECT * FROM serv_CouteragentNamePrefix pr WHERE pr.word = w.word AND pr.IdTreeNSICountry = @idCountry
	--����������


	)
	THEN ''
	ELSE
	' '+w.word 
	END AS VARCHAR(200))
	, w.id FROM w 
	JOIN ss ON ss.poz +1 = w.id 
	)
	--������� �������
	SELECT @shortName = RTRIM(LTRIM(
									REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(LTRIM(ss.short),' "',' '),'" ',' '),'"',' '),'�',''),'�','')
	)) FROM ss
	WHERE ss.poz = (SELECT MAX(poz) FROM ss)

	--�������� ��� �������� �������
	SELECT @shortName = CASE WHEN LEN(@shortName)>=100 THEN RTRIM(LEFT(@shortName,100)) ELSE RTRIM(@shortName) END

	RETURN @shortName
	
	
	
END

GO

DECLARE @result VARCHAR(10) = ' /FAIL'
IF(OBJECT_ID( N'udf_TreeNSI_GetCouteragentShortName') IS NOT NULL)
	SET @result = ' /OK'
print 'CREATE FUNCTION [dbo].[udf_TreeNSI_GetCouteragentShortName]' + @result

/************* ���� �������� ����� *************/
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'��������� �������� ������������ �����������' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'FUNCTION',@level1name=N'udf_TreeNSI_GetCouteragentShortName'
GO
/************* ����� ����� �������� ����� *************/

IF(OBJECT_ID( N'udf_TreeNSI_CheckCouteragentRegNumber') IS NOT NULL)
DROP FUNCTION [dbo].[udf_TreeNSI_CheckCouteragentRegNumber]
GO

--�������� �������� ��������������� ����� ������������

CREATE FUNCTION [dbo].[udf_TreeNSI_CheckCouteragentRegNumber]
(
@number VARCHAR(22), --���������������� ����� �����������
@idCountry INT, -- ��� ������
@IsNalog BIT = 1 --1 -������� ������ ����������� ��� ����������������� (��� (�� 10-��, 12-���), ��� (�� 9), ��� (������� 12-��, 10-���), 0- ��� ����� ����������� ������������ ���� (����� (��), ���� (��), ������ (�������))
)
RETURNS INT --0- �������� ��������, >0 - ������
AS
BEGIN
/*
�� 
	��� - 9 ��������

��
	��� - ������� 12 ��������, 2 ��������� - �������� 
	��� - �� ���� 10 ��������

	��� - (��� ������� ���������� �� ����) 9 �������� (���������) �� - ��� ��� ��������� ����� ���������� �������� ��� ����� � 01 �� 99

	���� (�������� ��������������� ��������������� ����� ������������ ����) - 13 ���� 
	������ (�������� ��������������� ��������������� ����� ������� ��� ��) - 15 ����

�������

	������ - (���������� ��� �� ���� ��� ��� ��������� � ������ ��� ������� ����������� � ����������� ������� - �������� �����������) 8 ����

	��� (I�� - i����i�������� ���������� �����) ����� ����������� ������� ��� �� ���� - 12 ���� (7 ������ ���� - ������ ��� ������������ �����), ��� ��� ���� - 10 ����
*/

--��������� ����������
DECLARE @x INT, @chSum BIGINT, @ost INT

--������� � �������� ��������������
--*********** �� ***********--
DECLARE @UNPtableRB TABLE(id INT, ves INT, poz INT) --��� ��� ��
INSERT INTO @UNPtableRB (id, ves)
VALUES
(1,29),
(2,23),
(3,19),
(4,17),
(5,13),
(6,7),
(7,5),
(8,3),
(9,0)

DECLARE @OKtableRB TABLE(id INT, ves INT, ves1 INT, ves12 INT, ves121 INT, poz INT) --����� ��� ��
INSERT INTO @OKtableRB (id, ves, ves1, ves12, ves121)
VALUES
(1,29,31,43,47),
(2,23,29,41,43),
(3,19,23,37,41),
(4,17,19,31,37),
(5,13,17,29,31),
(6,7,13,23,29),
(7,5,7,19,23),
(8,3,5,17,19),
(9,0,0,13,17),
(10,0,0,7,13),
(11,0,0,5,7),
(12,0,0,3,5),
(13,0,0,0,0)

--*********** �� ***********--
DECLARE @INNtableRF TABLE(id INT, ves INT, ves12 INT, ves121 INT, poz INT) --��� ��� ��
INSERT INTO @INNtableRF (id, ves, ves12, ves121)
VALUES
(1,2,7,3),
(2,4,2,7),
(3,10,4,2),
(4,3,10,4),
(5,5,3,10),
(6,9,5,3),
(7,4,9,5),
(8,6,4,9),
(9,8,6,4),
(10,0,8,6),
(11,0,0,8),
(12,0,0,0)

--*********** ������� ***********--
DECLARE @INNtableUA TABLE(id INT, ves INT, ves12 INT, ves121 INT, poz INT) --��� ��� �������
INSERT INTO @INNtableUA (id, ves, ves12, ves121)
VALUES
(1,-1,11,13),
(2,5,13,17),
(3,7,17,19),
(4,9,19,23),
(5,4,23,29),
(6,6,29,31),
(7,10,31,37),
(8,5,37,41),
(9,7,41,43),
(10,0,43,47),
(11,0,47,53),
(12,0,0,0)

DECLARE @EDRtableUA TABLE(id INT, ves INT, ves1 INT, ves12 INT, ves121 INT, poz INT) --����� ��� ��
INSERT INTO @EDRtableUA (id, ves, ves1, ves12, ves121)
VALUES
(1,1,7,3,9),
(2,2,1,4,3),
(3,3,2,5,4),
(4,4,3,6,5),
(5,5,4,7,6),
(6,6,5,8,7),
(7,7,6,9,8),
(8,0,0,0,0)

--/////////////////////////////////////////////////--

SET @number = RTRIM(LTRIM(@number))

IF @idCountry = 1 --��
	IF @IsNalog = 1 --���
		BEGIN

			IF LEN(@number) != 9
				RETURN -1 --�������� ����

			IF ISNUMERIC(@number) = 0 /*��� ������. ������������ ��� ����� ���������� � ��������� ��������� ����� (��� ���������� ������ ���������� �������)*/
				RETURN -1 --�� �����

			SET @x = 1
			WHILE @x <10 
				BEGIN
					UPDATE @UNPtableRB
					SET poz = CAST(SUBSTRING(@number,@x,1) AS INT)
					WHERE id = @x
					SET @x = @x+1
				END
			--/*������ ����� (��� ������) �������� ������, ��� ��� ����� ��������� � ��*/
			--IF (SELECT poz FROM @UNPtableRB WHERE id = 1) NOT LIKE '%'+'[1234567]'+'%'
			--	RETURN -2 --���������� �� �����


			SELECT @chSum = SUM(ves*poz) FROM @UNPtableRB
				WHERE id < 9

			IF (@chSum - FLOOR(@chSum/11)*11) != (SELECT poz FROM @UNPtableRB WHERE id = 9)
				RETURN -2 --�������� ����������� ���� �� ��������
			ELSE
				RETURN 0

		END
	ELSE --�����
		BEGIN

			IF LEN(@number) NOT IN (9,13)
				RETURN -1 --�������� ����

			IF ISNUMERIC(@number) = 0
				RETURN -1 --�� �����

			SET @x = 1
			WHILE @x < LEN(@number)+1 
				BEGIN
					UPDATE @OKtableRB
					SET poz = CAST(SUBSTRING(@number,@x,1) AS INT)
					WHERE id = @x
					SET @x = @x+1
				END

			SELECT @chSum = SUM((CASE WHEN LEN(@number) = 9 THEN ves ELSE ves12 END) *poz) FROM @OKtableRB
				WHERE id < LEN(@number)

			SET @Ost = @chSum - FLOOR(@chSum/11)*11
		
			IF @ost = 10
				BEGIN
					SELECT @chSum = SUM((CASE WHEN LEN(@number) = 9 THEN ves1 ELSE ves121 END) *poz) FROM @OKtableRB
						WHERE id < LEN(@number)

					SET @Ost = @chSum - FLOOR(@chSum/11)*11

				END

			SET @ost = CASE WHEN @ost = 10 THEN 0 ELSE @ost END

			IF @ost != (SELECT poz FROM @OKtableRB WHERE id=LEN(@number))
				RETURN -2 --�������� ����������� ���� �� ��������
			ELSE
				RETURN 0

		END
--------*****************************************------------------------------
IF @idCountry = 2 --��
	IF @IsNalog = 1 --���
		BEGIN
			IF LEN(@number) NOT IN (10,12)
				RETURN -1 --�������� ����
			IF ISNUMERIC(@number) = 0
				RETURN -1 --�� �����

			SET @x = 1
			WHILE @x < LEN(@number)+1 
				BEGIN
					UPDATE @INNtableRF
					SET poz = CAST(SUBSTRING(@number,@x,1) AS INT)
					WHERE id = @x
					SET @x = @x+1
				END
			SELECT @chSum = SUM((CASE WHEN LEN(@number) = 10 THEN ves ELSE ves12 END) *poz) FROM @INNtableRF
				WHERE id < LEN(@number)

			SET @Ost = @chSum - FLOOR(@chSum/11)*11

			SET @ost = CASE WHEN @ost > 9 THEN @ost - FLOOR(@ost/10)*10 ELSE @ost END

			IF LEN(@number) = 10 
				IF @ost != (SELECT poz FROM @INNtableRF WHERE id=LEN(@number))
					RETURN -2 --�������� ����������� ���� �� ��������
				ELSE
					RETURN 0 
			IF LEN(@number) = 12
				BEGIN
					IF @ost != (SELECT poz FROM @INNtableRF WHERE id=11) 
						RETURN -2 --�������� ����������� ���� �� ��������

					SELECT @chSum = SUM(ves121 *poz) FROM @INNtableRF
						WHERE id < 12
					SET @Ost = @chSum - FLOOR(@chSum/11)*11

					SET @ost = CASE WHEN @ost > 9 THEN @ost - FLOOR(@ost/10)*10 ELSE @ost END

					IF @ost != (SELECT poz FROM @INNtableRF WHERE id=12) 
						RETURN -2 --�������� ����������� ���� �� ��������
					ELSE
						RETURN 0

				END
		END
	ELSE --���� ��� ������
		BEGIN
			IF LEN(@number) NOT IN (13,15)
				RETURN -1 --�������� ����
			IF ISNUMERIC(@number) = 0
				RETURN -1 --�� �����

			IF LEN(@number) = 13 --����
				BEGIN
					SET @chSum = CAST(LEFT(@number,12) AS BIGINT)

					SET @Ost = @chSum - FLOOR(@chSum/11)*11

					SET @ost = CASE WHEN @ost > 9 THEN @ost - FLOOR(@ost/10)*10 ELSE @ost END

					IF @ost != CAST(RIGHT(@number,1) AS INT)
						RETURN -2 --�������� ����������� ���� �� ��������
					ELSE
						RETURN 0
				END
			IF LEN(@number) = 15 --������
				BEGIN
					SET @chSum = CAST(LEFT(@number,14) AS BIGINT)

					SET @Ost = @chSum - FLOOR(@chSum/13)*13

					SET @ost = CASE WHEN @ost > 9 THEN @ost - FLOOR(@ost/10)*10 ELSE @ost END

					IF @ost != CAST(RIGHT(@number,1) AS INT)
						RETURN -2 --�������� ����������� ���� �� ��������
					ELSE
						RETURN 0
				END 
		END
--------*****************************************------------------------------
IF @idCountry = 3
	IF @IsNalog = 1
		BEGIN
			IF LEN(@number) NOT IN (10,12)
				RETURN -1 --�������� ����
			IF ISNUMERIC(@number) = 0
				RETURN -1 --�� �����

			SET @x = 1
			WHILE @x < LEN(@number)+1 
				BEGIN
					UPDATE @INNtableUA
					SET poz = CAST(SUBSTRING(@number,@x,1) AS INT)
					WHERE id = @x
					SET @x = @x+1
				END

			SELECT @chSum = SUM((CASE WHEN LEN(@number) = 10 THEN ves ELSE ves12 END) *poz) FROM @INNtableUA
				WHERE id < LEN(@number)

			SET @Ost = @chSum - FLOOR(@chSum/11)*11

			IF LEN(@Number) = 10
				BEGIN

					SET @ost = CASE WHEN @ost >= 10 THEN 0 ELSE @ost END

					IF @ost != (SELECT poz FROM @INNtableUA WHERE id=LEN(@number))
						RETURN -2 --�������� ����������� ���� �� ��������
					ELSE
						RETURN 0
				END

			IF LEN(@Number) = 12
				BEGIN

					IF @ost = 10
						BEGIN
							SELECT @chSum = SUM(ves121 *poz) FROM @INNtableUA
								WHERE id < LEN(@number)

							SET @Ost = @chSum - FLOOR(@chSum/11)*11

							SET @ost = CASE WHEN @ost >= 10 THEN 0 ELSE @ost END
						END

					IF @ost != (SELECT poz FROM @INNtableUA WHERE id=LEN(@number))
						RETURN -2 --�������� ����������� ���� �� ��������
					ELSE
						RETURN 0
				END

		END
	ELSE -- ������
		BEGIN

			IF LEN(@number) != 8
				RETURN -1 --�������� ����

			IF ISNUMERIC(@number) = 0 
				RETURN -1 --�� �����

			SET @x = 1
			WHILE @x <9 
				BEGIN
					UPDATE @EDRtableUA
					SET poz = CAST(SUBSTRING(@number,@x,1) AS INT)
					WHERE id = @x
					SET @x = @x+1
				END

			IF CAST(@number AS BIGINT) > 30000000 AND CAST(@number AS BIGINT) < 60000000
				SELECT @chSum = SUM(ves1 *poz) FROM @EDRtableUA
					WHERE id < 8
			ELSE
				SELECT @chSum = SUM(ves *poz) FROM @EDRtableUA
					WHERE id < 8

			SET @Ost = @chSum - FLOOR(@chSum/11)*11

			IF @ost >= 10
				BEGIN
					IF CAST(@number AS BIGINT) > 30000000 AND CAST(@number AS BIGINT) < 60000000
						SELECT @chSum = SUM(ves121 *poz) FROM @EDRtableUA
							WHERE id < 8
					ELSE
						SELECT @chSum = SUM(ves12 *poz) FROM @EDRtableUA
							WHERE id < 8

					SET @Ost = @chSum - FLOOR(@chSum/11)*11

				END

			SET @ost = CASE WHEN @ost >= 10 THEN 0 ELSE @ost END

			IF @ost != (SELECT poz FROM @EDRtableUA WHERE id=8)
				RETURN -2 --�������� ����������� ���� �� ��������
			ELSE
				RETURN 0
		END
--------*****************************************------------------------------

RETURN 1 --�������� �� ��������������

END

GO

DECLARE @result VARCHAR(10) = ' /FAIL'
IF(OBJECT_ID( N'udf_TreeNSI_CheckCouteragentRegNumber') IS NOT NULL)
	SET @result = ' /OK'
print 'CREATE FUNCTION [dbo].[udf_TreeNSI_CheckCouteragentRegNumber]' + @result

/************* ���� �������� ����� *************/
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'�������� ���������������� ������ �����������' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'FUNCTION',@level1name=N'udf_TreeNSI_CheckCouteragentRegNumber'
GO
/************* ����� ����� �������� ����� *************/

IF(OBJECT_ID( N'usp_TreeNSI_serv_CounteragentMorphologicalDuplicationCheck') IS NOT NULL)
DROP FUNCTION [dbo].[usp_TreeNSI_serv_CounteragentMorphologicalDuplicationCheck]
GO

--��������� ��������������� �������� ������� ����� ��������� ������������ � ���������� �����������

CREATE PROCEDURE [dbo].[usp_TreeNSI_serv_CounteragentMorphologicalDuplicationCheck]
	(
	@name VARCHAR(300),            --����������� ������������
	@isGroup BIT,                  --��� ������ 
	@countryId INT,                --������ �����������
	@textError VARCHAR(1000) OUT   --����� ������  
	)

AS
SET NOCOUNT ON
BEGIN
	DECLARE @Return INT --���������� �������� ������
	SET @Return = 0

	IF @countryId IS NULL
		BEGIN
			SET @textError = '�� ������� ������ �����������' 
			SET @Return = -1
			RETURN @Return
		END

	IF (SELECT COUNT(*) FROM view_TreeNSI_Country WHERE IdCountry = @countryId) = 0
		BEGIN
			SET @textError = 'C����� ����������� �� ����������' 
			SET @Return = -1
			RETURN @Return
		END


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

	UPDATE @words
	SET isMain = CASE WHEN word LIKE '%[0123456789QWERTYUIOPASDFGHJKLZXCVBNM]%' THEN 2
					WHEN word LIKE '%������%' THEN 2
					WHEN word LIKE '%�����%' THEN 2
					WHEN word LIKE '%����%' THEN 2
					WHEN word LIKE '%���%' THEN 2
					WHEN word LIKE '%�-�%' THEN 2
				 ELSE 1 END

	UPDATE @words
	SET word = REPLACE(REPLACE(REPLACE(REPLACE(word,'-',''),'/',''),'(',''),')','')

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

	,z (couteragentId, name, step)
	AS
		(SELECT p.IdCounteragent, p.Name, t.idW FROM 
		(SELECT DISTINCT n.IdCounteragent, name = ISNULL(n.Name,pr.FullName ) FROM dbo.TreeNSI_Counteragent n 
		LEFT JOIN dbo.TreeNSI_CounteragentProperty pr ON pr.IdElement = n.IdCounteragent
		WHERE n.IdCountry = @countryId AND
		1 = CASE WHEN @isGroup IS NULL THEN 1 ELSE CASE WHEN @isGroup = n.IsGroup THEN 1 ELSE 0 END END) p
		JOIN words t ON t.idW = (SELECT MIN(idW) FROM words WHERE isMain > 0) 
		AND REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(p.name,'-',''),'/',''),'(',''),')',''),'.',' ') 
		LIKE '%'+t.word+'%' 
		AND len(p.name) >= @len 
		UNION ALL
		SELECT z.couteragentId, z.name, t.idW FROM z
		JOIN words t ON t.idW = z.step +1 
		AND t.isMain > 0 AND REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(z.name,'-',''),'/',''),'(',''),')',''),'.',' ') 
		LIKE '%'+t.word+'%'
		)
	, az (id, code,name)
	AS
		(SELECT id = ROW_NUMBER() OVER (ORDER BY couteragentId), couteragentId, name FROM z
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

DECLARE @result VARCHAR(10) = ' /FAIL'
IF(OBJECT_ID( N'usp_TreeNSI_serv_CounteragentMorphologicalDuplicationCheck') IS NOT NULL)
	SET @result = ' /OK'
print 'CREATE FUNCTION [dbo].[usp_TreeNSI_serv_CounteragentMorphologicalDuplicationCheck]' + @result

/************* ���� �������� ����� *************/
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'��������� ��������������� �������� �� ������������ ������������ � ����������� �����������. �������� ���������� ��������� ������' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'usp_TreeNSI_serv_CounteragentMorphologicalDuplicationCheck'
GO
/************* ����� ����� �������� ����� *************/



IF(OBJECT_ID( N'usp_TreeNSI_AddCounteragent') IS NOT NULL)
DROP PROCEDURE [dbo].[usp_TreeNSI_AddCounteragent]
GO

--��������� ���������� ������ �������� ����������� �����������

CREATE PROCEDURE [dbo].[usp_TreeNSI_AddCounteragent]
	(
	@Name VARCHAR(100) = NULL,              -- ������������ ��� ������
	@IsGroup BIT,                           -- ��� ������
	@IdCountry INT,                         -- ��� ������ �����������
	@ParentId INT = NULL,                   -- ��� ������������ ������ � ����������� ���������� (IdCounteragent)
	@FullName VARCHAR(300),                 -- ������ ������������
	@BeginDate DATETIME = NULL,             -- ���� ��������� ������������� ����������

	@RegistrationNumber VARCHAR(20) = NULL, --�������� ��������������� ��� ������������ ���� � ������ �����������

	@CutOffMorphologicalDuplicationCheck BIT = NULL, --�������������� ���������� ��������������� �������� (������� ������ � ���������� ������� ������� ��� ��� �������)
	
	@user INT = NULL,                       -- ��� ������������ � ������� TreeNSI
	@returnId INT  = NULL OUTPUT            -- ���������� ��� ����������� (IdCounteragent)
	)

AS
SET NOCOUNT ON
BEGIN
	
	SET @returnId = -1
	--��������� ���������--
	DECLARE @IdProcedure INT         --��������� ��� ���������
	SET @IdProcedure =  OBJECT_ID(N'dbo.usp_TreeNSI_AddCounteragent')
	DECLARE @parameters XML          --������� ���������
	SET @parameters = (SELECT @Name AS 'Name', @IsGroup AS 'IsGroup',@IdCountry AS 'IdCountry' , @ParentId AS 'ParentId', @FullName AS 'FullName', @BeginDate AS 'BeginDate', @RegistrationNumber AS 'RegistrationNumber', @user AS 'user', @returnId AS 'returnId' FOR XML RAW) 
	DECLARE @directoryType INT       --��� �����������
	SET @directoryType = 3
	DECLARE @ErrorText VARCHAR(1000) --����� ������

	DECLARE @CountBranch INT            --���������� ������� � ���������� ��� ��� ����������� ��
	--***********************--



	SET @user = ISNULL(@user,(SELECT dbo.udf_TreeNSI_GetIdUser()))
	IF @user IS NULL OR (SELECT dbo.udf_TreeNSI_serv_CheckUser(@user)) = 0
		BEGIN
			SET @ErrorText = '������������ � ����� '+CAST(@user AS VARCHAR)+' ('+USER+') �� �������� �������� ������������� �������'
			EXEC	[dbo].[usp_TreeNSI_serv_WriteErrorLog]	@isFatalError = 1, @text = @ErrorText,	@user = @user,	@directoryType = @directoryType, @idElement = NULL,	@ErrorSource = @IdProcedure, @Parameters = @parameters

			RETURN
		END

	
	SET @FullName = REPLACE(@FullName,'''','" ')
	SET @FullName = REPLACE(@FullName,'�','" ')
	SET @FullName = REPLACE(@FullName,'�','" ')
	SET @FullName = REPLACE(@FullName,'  ',' ')
	SET @FullName = REPLACE(@FullName,'  ',' ')

	SET @FullName = RTRIM(LTRIM(ISNULL(@FullName,'')))
	IF LEN(@FullName) < 3 OR ISNUMERIC(@FullName) = 1
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
			IF (SELECT COUNT(*) FROM dbo.TreeNSI_Counteragent WHERE IdCounteragent = @ParentId AND IsGroup = 1) = 0
				BEGIN
					SET @ParentId = NULL
					SET @ErrorText = '�� ������� ��������� ������������ ������'
					EXEC	[dbo].[usp_TreeNSI_serv_WriteErrorLog]	@isFatalError = 0, @text = @ErrorText,	@user = @user,	@directoryType = @directoryType, @idElement = NULL,	@ErrorSource = @IdProcedure, @Parameters = @parameters

				END
		END

	--�������� ������� ������ �����������
	IF @IdCountry IS NULL
		BEGIN
			SET @ErrorText = '�� ������� ������ ����������� �����������'
			EXEC	[dbo].[usp_TreeNSI_serv_WriteErrorLog]	@isFatalError = 1, @text = @ErrorText,	@user = @user,	@directoryType = @directoryType, @idElement = NULL,	@ErrorSource = @IdProcedure, @Parameters = @parameters

			RETURN
		END

	IF (SELECT COUNT(*) FROM dbo.TreeNSI_Country WHERE IdCountry = @IdCountry) = 0
			BEGIN
				SET @ParentId = NULL
				SET @ErrorText = '�� ������� ��������� ������ �����������'
				EXEC	[dbo].[usp_TreeNSI_serv_WriteErrorLog]	@isFatalError = 0, @text = @ErrorText,	@user = @user,	@directoryType = @directoryType, @idElement = NULL,	@ErrorSource = @IdProcedure, @Parameters = @parameters

			END

	IF LEN(ISNULL(@Name,'')) <= 3
		BEGIN
			SELECT @Name = dbo.udf_TreeNSI_GetCouteragentShortName(@Fullname,@IdCountry)
			
			IF LEN(@Name) <=3
				SET @Name = RTRIM(LEFT(@FullName,100))

		END


	--�������� �� ����� �� ��� �������--
	IF @RegistrationNumber IS NOT NULL
		SET @RegistrationNumber = RTRIM(LTRIM(@RegistrationNumber))

	IF @IdCountry = 1 
		--��� �� �������� �� ��� �����������
		BEGIN
			IF LEN(ISNULL(@RegistrationNumber ,'')) != 9
				BEGIN
					SET @ErrorText = '��� ����������� �� �� ������ ���'
					EXEC	[dbo].[usp_TreeNSI_serv_WriteErrorLog]	@isFatalError = 1, @text = @ErrorText,	@user = @user,	@directoryType = @directoryType, @idElement = NULL,	@ErrorSource = @IdProcedure, @Parameters = @parameters

					RETURN
				END

			IF dbo.udf_TreeNSI_CheckCouteragentRegNumber(@RegistrationNumber,@IdCountry,1) < 0
				BEGIN
					SET @ErrorText = '��� ����������� �� �� ����� ������ ���'
					EXEC	[dbo].[usp_TreeNSI_serv_WriteErrorLog]	@isFatalError = 1, @text = @ErrorText,	@user = @user,	@directoryType = @directoryType, @idElement = NULL,	@ErrorSource = @IdProcedure, @Parameters = @parameters

					RETURN
				END

			SELECT @CountBranch = COUNT(*) FROM TreeNSI_CounteragentRegistrationNumber RN
			JOIN TreeNSI_CounteragentRegistrationNumbersType t ON t.IdCountry = @IdCountry AND RN.IdRegNumberType = t.IdRegNumberType AND t.IsMain = 1
				WHERE RN.Number = @RegistrationNumber 
		 
		END
	ELSE
		--��� ��������� ������
		IF @RegistrationNumber IS NOT NULL
			BEGIN
				--���������� ����� ��������� ��� ����� �� ������������ ����������
				/*IF dbo.udf_TreeNSI_CheckCouteragentRegNumber(@RegistrationNumber,@IdCountry,0) < 0
					BEGIN
						SET @ErrorText = '��� ����������� �� �� ����� ������ ���'
						EXEC	[dbo].[usp_TreeNSI_serv_WriteErrorLog]	@isFatalError = 1, @text = @ErrorText,	@user = @user,	@directoryType = @directoryType, @idElement = NULL,	@ErrorSource = @IdProcedure, @Parameters = @parameters

						RETURN
					END*/

				IF (SELECT COUNT(*) FROM TreeNSI_CounteragentRegistrationNumber RN
					JOIN TreeNSI_CounteragentRegistrationNumbersType t ON t.IdCountry = @IdCountry AND RN.IdRegNumberType = t.IdRegNumberType AND t.IsMain = 1
					WHERE RN.Number = @RegistrationNumber) > 0 
					AND @ParentId IS NULL --�������� �����, ��� ���������� �� �������� ����������� ���� ����
						BEGIN
							SET @ErrorText = '� ����������� ��� ������ ����������� � ����� ��������������� �������'
							EXEC	[dbo].[usp_TreeNSI_serv_WriteErrorLog]	@isFatalError = 1, @text = @ErrorText,	@user = @user,	@directoryType = @directoryType, @idElement = NULL,	@ErrorSource = @IdProcedure, @Parameters = @parameters
							RETURN
						END
			END

	--�������� �� ����� �� ������������ ��� "������������" ������������
	IF @RegistrationNumber IS NULL OR ISNULL(@CountBranch,0) > 0
		BEGIN
		----------******************---------------
			DECLARE @return_value INT --���������� ������� �������
			EXEC	@return_value = [dbo].[usp_TreeNSI_serv_CounteragentMorphologicalDuplicationCheck]
				@name = @Name,
				@isGroup = @IsGroup,
				@countryId = @IdCountry,
				@textError = @ErrorText OUTPUT
		----------******************---------------
			

			IF (@return_value != 0)
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
	
			INSERT INTO [dbo].[TreeNSI_Counteragent]
				   ([IdCatalog]
				   ,[IsGroup]
				   ,[ParentId]
				   ,[Name]
				   ,[IdCountry])
			 VALUES
				   (@idCatalog
				   ,@IsGroup
				   ,@ParentId
				   ,@Name
				   ,@IdCountry)
			SET @returnId = CAST(SCOPE_IDENTITY() AS INT)
		
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
				SET @ErrorText = '�� ������� �������� ����� ������� '+ LEFT(ERROR_MESSAGE(),CASE WHEN LEN(ISNULL(ERROR_MESSAGE(),''))> 945 THEN 945 ELSE LEN(ISNULL(ERROR_MESSAGE(),'')) END)
				EXEC	[dbo].[usp_TreeNSI_serv_WriteErrorLog]	@isFatalError = 1, @text = @ErrorText,	@user = @user,	@directoryType = @directoryType, @idElement = NULL,	@ErrorSource = @IdProcedure, @Parameters = @parameters

				SET @returnId = -1
	
				RETURN
			END
	END CATCH
	
	--������� �������� ������ ������������--
	
	IF LEN(@FullName) >= LEN(@Name) 
		BEGIN
			
			INSERT INTO [dbo].[TreeNSI_CounteragentProperty]
				   ([IdElement]
				   ,[BeginDate]
				   ,[FullName]
				   ,IsActive)
			 VALUES
				   (@returnId
				   ,ISNULL(@BeginDate,@DateRegistration)
				   ,@FullName
				   ,1
				   )

		END
	ELSE
		BEGIN

			ROLLBACK TRANSACTION
				SET @ErrorText = '������������ ������ ������������ �� ������ ���� ������ �������� '+ LEFT(ISNULL(ERROR_MESSAGE(),''),CASE WHEN LEN(ISNULL(ERROR_MESSAGE(),''))> 945 THEN 945 ELSE LEN(ISNULL(ERROR_MESSAGE(),'')) END)
				EXEC	[dbo].[usp_TreeNSI_serv_WriteErrorLog]	@isFatalError = 1, @text = @ErrorText,	@user = @user,	@directoryType = @directoryType, @idElement = NULL,	@ErrorSource = @IdProcedure, @Parameters = @parameters

				SET @returnId = -1
	
				RETURN

		END

	COMMIT TRANSACTION --����� ������ �� �����������


	--������� �������� ���������������� �����
	IF @RegistrationNumber IS NOT NULL
		BEGIN
			DECLARE @MainRegNumberType INT

			SELECT TOP 1 @MainRegNumberType = IdRegNumberType FROM TreeNSI_CounteragentRegistrationNumbersType 
			WHERE IdCountry = @IdCountry AND IsMain = 1
			ORDER BY IsActive DESC

			IF @MainRegNumberType IS NULL
				BEGIN
					SET @ErrorText = '��� ������ '+(SELECT Name FROM view_TreeNSI_Country WHERE IdCountry = @IdCountry)+' �� ��������� ��� ��������� ���������������� ������ �����������. ���. ����� ����������� �������� �� �����'
					EXEC	[dbo].[usp_TreeNSI_serv_WriteErrorLog]	@isFatalError = 0, @text = @ErrorText,	@user = @user,	@directoryType = @directoryType, @idElement = NULL,	@ErrorSource = @IdProcedure, @Parameters = @parameters
				END
			ELSE
				BEGIN

					INSERT INTO [dbo].[TreeNSI_CounteragentRegistrationNumber]
						   ([IdCounteragent]
						   ,[IdRegNumberType]
						   ,[Number])
					 VALUES
						   (@returnId
						   ,@MainRegNumberType
						   ,@RegistrationNumber)

				END

			IF ISNULL(@CountBranch,0) > 0 AND  @ParentId IS NULL
			--�������� ������ ��� ��
				BEGIN
					SELECT @ParentId = p.IdCounteragent FROM TreeNSI_Counteragent p
					JOIN TreeNSI_CounteragentRegistrationNumber N ON N.Number = @RegistrationNumber
					JOIN TreeNSI_CounteragentRegistrationNumbersType NT ON NT.IdCountry = @IdCountry AND NT.IsMain = 1 AND NT.IdRegNumberType = N.IdRegNumberType
					WHERE p.IdCounteragent != @returnId AND 1 = CASE WHEN @CountBranch = 1 THEN 1 ELSE CASE WHEN p.IsGroup = 1 THEN 1 ELSE 0 END END


					IF @CountBranch = 1
						BEGIN
							DECLARE @ParentFullName VARCHAR(300)
	
							SELECT @ParentFullName = FullName FROM view_TreeNSI_Counteragent WHERE IdCounteragent = @ParentId
	
							IF (@ParentFullName LIKE '%������%' OR @ParentFullName LIKE '%�����%' OR @ParentFullName LIKE '%��-�%' OR @ParentFullName LIKE '%���-%' OR @ParentFullName LIKE '%����-%')
							AND (@FullName NOT LIKE '%������%' AND @FullName NOT LIKE '%�����%' AND @FullName NOT LIKE '%��-�%' AND @FullName NOT LIKE '%���-%' AND @FullName NOT LIKE '%����-%')
								BEGIN
									--������ ��������� ������ ���� �� ������ ������, ����� ��� ������ ��������� ����� �������� � ���� ���������
									UPDATE [dbo].[TreeNSI_Counteragent]
									SET [ParentId] = @returnId
									WHERE IdCounteragent = @ParentId

									UPDATE [dbo].[TreeNSI_Counteragent]
									SET [IsGroup] = 1
									WHERE IdCounteragent = @returnId

									SET @ErrorText = '����� ���������� '+@FullName+' ����� �������� � ���� ��������� ����������� ��� ����� ��������� '+@ParentFullName+' � ����� '+@ParentId+'. �������� �������������'
									SET @ParentId = NULL
									EXEC	[dbo].[usp_TreeNSI_serv_WriteErrorLog]	@isFatalError = 0, @text = @ErrorText,	@user = @user,	@directoryType = @directoryType, @idElement = NULL,	@ErrorSource = @IdProcedure, @Parameters = @parameters
								END
						END

					IF @ParentId IS NOT NULL
						BEGIN
							UPDATE [dbo].[TreeNSI_Counteragent]
							SET [ParentId] = @ParentId
							WHERE IdCounteragent = @returnId

							SET @ErrorText = '����� ���������� '+@FullName+' ��� ������������� �������� ������ � ����� '+@ParentId+'.'
							SET @ParentId = NULL
							EXEC	[dbo].[usp_TreeNSI_serv_WriteErrorLog]	@isFatalError = 0, @text = @ErrorText,	@user = @user,	@directoryType = @directoryType, @idElement = NULL,	@ErrorSource = @IdProcedure, @Parameters = @parameters

						END

				END
		END
	
END
GO

DECLARE @result VARCHAR(10) = ' /FAIL'
IF(OBJECT_ID( N'usp_TreeNSI_AddCounteragent') IS NOT NULL)
	SET @result = ' /OK'
print 'CREATE PROCEDURE [dbo].[usp_TreeNSI_AddCounteragent]' + @result

/************* ���� �������� ����� *************/
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'���������� ������ �������� ����������� �����������' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'usp_TreeNSI_AddCounteragent'
GO
/************* ����� ����� �������� ����� *************/

print 'END InsertCounteragentHelper ' + CONVERT(VARCHAR(50) ,GetDATE(), 113 )
