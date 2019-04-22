USE [TreeNSI_test]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/****************************************************************/
/****************************************************************/
/**           Helper ��� ������ � �������������� �������       **/
/****************************************************************/
/****************************************************************/

print 'BEGIN PeriodicDataHelper ' + CONVERT(VARCHAR(50) ,GetDATE(), 113 )

IF(OBJECT_ID( N'usp_TreeNSI_GetPeriodicDataFromView') IS NOT NULL)
DROP PROCEDURE [dbo].[usp_TreeNSI_GetPeriodicDataFromView]
GO

--��������� ��������� ������ ��� ������������� ������������ �� ��������� ���� �� ���������� ����������� �������������

CREATE PROCEDURE [dbo].[usp_TreeNSI_GetPeriodicDataFromView]
	(
	@viewName NVARCHAR(100),  --��� ������������ � ����������� ������� �������������� �����������
	@beginDate DATE			  --���� ������������
	)

AS
SET NOCOUNT ON
BEGIN
	
	DECLARE @sqlText NVARCHAR(max)

	SET @beginDate = ISNULL(@beginDate,CAST(GETDATE() AS DATE))

	IF OBJECT_ID(@viewName) IS NULL OR (SELECT [type] FROM [sys].[all_objects] WHERE object_id = OBJECT_ID(@viewName)) != 'V'
		RETURN -1

	SELECT @sqlText = [definition]
    FROM [sys].[all_sql_modules]
    WHERE object_id = OBJECT_ID(@viewName)

	IF CHARINDEX('/*;START;*/',@sqlText,1) = 0
	OR CHARINDEX('/*;END;*/',@sqlText,1) = 0
	OR CHARINDEX('/*;@;*/',@sqlText,1) = 0
		BEGIN
			SET @sqlText = N'SELECT * FROM '+@viewName
			EXECUTE sp_executesql @sqlText
			RETURN 0
		END
	
	BEGIN TRY
	
		SELECT @sqlText= SUBSTRING(@sqlText,CHARINDEX('/*;START;*/',@sqlText,1),CHARINDEX('/*;END;*/',@sqlText,1)-CHARINDEX('/*;START;*/',@sqlText,1))
		SELECT @sqlText = REPLACE(@sqlText,'/*;@;*/','WHERE BeginDate <= @d')

		EXECUTE sp_executesql @sqlText, N'@d DATE', @d = @beginDate

		RETURN 1

	END TRY

	BEGIN CATCH

		SET @sqlText = N'SELECT * FROM '+@viewName

		EXECUTE sp_executesql @sqlText

		RETURN 0

	END CATCH

	
END

GO

DECLARE @result VARCHAR(10) = ' /FAIL'
IF(OBJECT_ID( N'usp_TreeNSI_GetPeriodicDataFromView') IS NOT NULL)
	SET @result = ' /OK'
print 'CREATE PROCEDURE [dbo].[usp_TreeNSI_GetPeriodicDataFromView]' + @result

/************* ���� �������� ����� *************/
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'��������� ���������� �� ��������� ���� ������ �� �������������� ����������� (�������������)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'usp_TreeNSI_GetPeriodicDataFromView'
GO
/************* ����� ����� �������� ����� *************/


IF(OBJECT_ID( N'usp_TreeNSI_GetConditionForPeriodicData') IS NOT NULL)
DROP PROCEDURE [dbo].[usp_TreeNSI_GetConditionForPeriodicData]
GO

--��������� ��������� ������������� ������� ��� ����������� �������������� �����������

CREATE PROCEDURE [dbo].[usp_TreeNSI_GetConditionForPeriodicData]
	(
	@propertyTableName VARCHAR(100),		--��� �������, ��� �������� ������� �������������� �����������
	@date DATE,								--���� ������������
	@condition VARCHAR(1000) OUT			--������������ ������ (�������� ��������������� ����� �������, ������� �������� ���������� ������ �� ��������� � @date ����)
	)

AS
SET NOCOUNT ON
BEGIN
	
	SET @condition = ''
	IF (LEN(RTRIM(ISNULL(@propertyTableName,''))) = 0 OR (OBJECT_ID(@propertyTableName) IS NULL))
	RETURN -1

	DECLARE @sqlText NVARCHAR(1000)
	SET @date = ISNULL(@date,GETDATE())
	
	SET @sqlText = N'SELECT @str =(SELECT 
	CAST(q.IdElement AS VARCHAR(12)) + '','' AS ''data()''
	FROM (SELECT p.IdElement FROM '+@propertyTableName +' p
	GROUP BY p.IdElement
	HAVING MIN(p.BeginDate) > @dd ) q FOR XML PATH(''''))'

	BEGIN TRY
				  
		EXECUTE sp_executesql @sqlText, N'@str VARCHAR(1000) OUTPUT, @dd DATE', @str = @condition OUTPUT ,@dd = @date

	END TRY
	BEGIN CATCH
		SET @condition = ''
	RETURN -1;
	END CATCH

	SELECT @condition = ( CASE WHEN (LEN(@condition) = 0) THEN ''
					  WHEN (@condition IS NULL) THEN ''
					  ELSE
					  LEFT(@condition,LEN(@condition)-1)
					  END)
	RETURN 1
	
END

GO

DECLARE @result VARCHAR(10) = ' /FAIL'
IF(OBJECT_ID( N'usp_TreeNSI_GetConditionForPeriodicData') IS NOT NULL)
	SET @result = ' /OK'
print 'CREATE PROCEDURE [dbo].[usp_TreeNSI_GetConditionForPeriodicData]' + @result

/************* ���� �������� ����� *************/
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'��������� ������, ��������������� ������ �������������� ����������� �� ����' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'usp_TreeNSI_GetConditionForPeriodicData'
GO
/************* ����� ����� �������� ����� *************/
print 'END PeriodicDataHelper ' + CONVERT(VARCHAR(50) ,GetDATE(), 113 )