USE [TreeNSI]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/****************************************************************/
/****************************************************************/
/**Helper для ввода элемента в типовой периодический справочник**/
/****************************************************************/
/****************************************************************/

--***************************************************************--
--**  ДЛЯ КОРРЕКТНОЙ РАБОТЫ НЕОБХОДИМО, ЧТОБЫ COLLATE В ПОЛЯХ  **--
--**       ТАБЛИЦ БЫЛИ ТАКИЕ ЖЕ, КАК ДЛЯ БД В ЦЕЛОМ!!!         **--
--***************************************************************--

--***************************************************************--
--**   ДЛЯ КОРРЕКТНОЙ РАБОТЫ НЕОБХОДИМ ЗАПОЛНЕННЫЙ СПРАВОЧНИК  **--
--**      TreeNSI_DirectoryType (поле IsBaseStructure)         **--
--***************************************************************--

print 'BEGIN InsertBasePeriodicElementHelper ' + CONVERT(VARCHAR(50) ,GetDATE(), 113 )

IF(OBJECT_ID( N'usp_TreeNSI_AddBasePeriodicElement') IS NOT NULL)
DROP PROCEDURE [dbo].[usp_TreeNSI_AddBasePeriodicElement]
GO

--Процедура добавления нового переодического элемента в справочники TreeNSI

CREATE PROCEDURE [dbo].[usp_TreeNSI_AddBasePeriodicElement]
	(
	@DirectoryType INT,               -- Код типа справочника
	@Name VARCHAR(300),               -- Наименование для поиска
	@IsGroup BIT,                     -- Это группа
	@ParentId INT = NULL,             -- Код родительской группы в справочнике 
	@FullName VARCHAR(500) = NULL,    -- Полное наименование
	@BeginDate DATETIME = NULL,       -- Дата установки периодических реквизитов
	
	@user INT = NULL,                 -- Код пользователя в системе TreeNSI
	@returnId INT  = NULL OUTPUT      -- Присвоеный код
	)

AS
SET NOCOUNT ON
BEGIN
	
	SET @returnId = -1
	--Служебные константы--
	DECLARE @IdProcedure INT         --Системный код процедуры
	SET @IdProcedure =  OBJECT_ID(N'dbo.usp_TreeNSI_AddBasePeriodicElement')
	DECLARE @parameters XML          --Входные параметры
	SET @parameters = (SELECT @DirectoryType AS 'DirectoryType', @Name AS 'Name', @IsGroup AS 'IsGroup', @ParentId AS 'ParentId', @FullName AS 'FullName', @BeginDate AS 'BeginDate', @user AS 'user', @returnId AS 'returnId' FOR XML RAW) 
	
	DECLARE @ErrorText VARCHAR(1000) --Текст ошибки


	DECLARE @sqlText NVARCHAR(1000) --Текст QSL запросов
	--***********************--



	SET @user = ISNULL(@user,(SELECT dbo.udf_TreeNSI_GetIdUser()))
	IF @user IS NULL OR (SELECT dbo.udf_TreeNSI_serv_CheckUser(@user)) = 0
		BEGIN
			SET @ErrorText = 'Пользователь с кодом '+CAST(@user AS VARCHAR)+' ('+USER+') не является активным пользователем системы'
			EXEC	[dbo].[usp_TreeNSI_serv_WriteErrorLog]	@isFatalError = 1, @text = @ErrorText,	@user = @user,	@directoryType = @directoryType, @idElement = NULL,	@ErrorSource = @IdProcedure, @Parameters = @parameters

			RETURN
		END

	IF NOT EXISTS (SELECT * FROM TreeNSI_DirectoryType WHERE IdDirectoryType = @DirectoryType)
		BEGIN
			SET @ErrorText = 'Неопределен тип справочника'
			EXEC	[dbo].[usp_TreeNSI_serv_WriteErrorLog]	@isFatalError = 1, @text = @ErrorText,	@user = @user,	@directoryType = @directoryType, @idElement = NULL,	@ErrorSource = @IdProcedure, @Parameters = @parameters

			RETURN
		END

	IF NOT EXISTS (SELECT * FROM TreeNSI_DirectoryType WHERE IdDirectoryType = @DirectoryType
	AND IsMultilevel = 1 AND IsPeriodic = 1
	AND OnlyRegistation = 0 AND IsBaseStructure = 1)
		BEGIN
			SET @ErrorText = 'Указанный тип справочника данной процедурой не обрабатывается'
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
			SET @ErrorText = 'Слишком мало информации для записи'
			EXEC	[dbo].[usp_TreeNSI_serv_WriteErrorLog]	@isFatalError = 1, @text = @ErrorText,	@user = @user,	@directoryType = @directoryType, @idElement = NULL,	@ErrorSource = @IdProcedure, @Parameters = @parameters

			RETURN
		END


	IF @IsGroup IS NULL
		BEGIN
			SET @ErrorText = 'Неопределен признак группы'
			EXEC	[dbo].[usp_TreeNSI_serv_WriteErrorLog]	@isFatalError = 1, @text = @ErrorText,	@user = @user,	@directoryType = @directoryType, @idElement = NULL,	@ErrorSource = @IdProcedure, @Parameters = @parameters

			RETURN
		END

	--Проверка на наличие родителя--
	IF @ParentId IS NOT NULL
		BEGIN
			DECLARE @countParent INT = 0
			SET @sqlText = N'SELECT @count =(SELECT 
			COUNT(*) FROM '+(SELECT RTRIM(TableName) FROM TreeNSI_DirectoryType WHERE IdDirectoryType = @DirectoryType)+
			' WHERE '+(SELECT RTRIM(col.[name])
						FROM [sys].[all_columns] col
						JOIN [sys].[tables] t ON t.object_id = col.object_id
						JOIN TreeNSI_DirectoryType DT ON DT.TableName = t.name AND DT.IdDirectoryType = @DirectoryType
						WHERE is_identity = 1) 
			+ ' = @ParentId AND IsGroup = 1)'


			BEGIN TRY
				  
				EXECUTE sp_executesql @sqlText, N'@count INT OUTPUT, @ParentId INT', @count = @countParent OUTPUT ,@ParentId = @ParentId

			END TRY
			BEGIN CATCH
				BEGIN
					SET @ErrorText = 'Ошибка при проверке наличия родительской группы'
					EXEC	[dbo].[usp_TreeNSI_serv_WriteErrorLog]	@isFatalError = 1, @text = @ErrorText,	@user = @user,	@directoryType = @directoryType, @idElement = NULL,	@ErrorSource = @IdProcedure, @Parameters = @parameters

					RETURN
				END
			END CATCH

			IF @countParent = 0
				BEGIN
					SET @ParentId = NULL
					SET @ErrorText = 'Не найдена указанная родительская группа'
					EXEC	[dbo].[usp_TreeNSI_serv_WriteErrorLog]	@isFatalError = 0, @text = @ErrorText,	@user = @user,	@directoryType = @directoryType, @idElement = NULL,	@ErrorSource = @IdProcedure, @Parameters = @parameters

				END
		END


	SET @FullName = RTRIM(LTRIM(ISNULL(@FullName,@Name)))
	--Проверка на длинну записываемых наименований
	DECLARE @Len INT
	SET @Len = (SELECT col.max_length
				FROM [sys].[all_columns] col
				JOIN [sys].[tables] t ON t.object_id = col.object_id
				JOIN TreeNSI_DirectoryType DT ON DT.TableName = t.name AND DT.IdDirectoryType = @DirectoryType
				WHERE col.name = 'Name') 

	IF @Len IS NULL --нет такого столбца
		BEGIN
			SET @ErrorText = 'Поле "Name" отсутствует в таблице справочника'
			EXEC	[dbo].[usp_TreeNSI_serv_WriteErrorLog]	@isFatalError = 1, @text = @ErrorText,	@user = @user,	@directoryType = @directoryType, @idElement = NULL,	@ErrorSource = @IdProcedure, @Parameters = @parameters

			RETURN
		END
	ELSE
		BEGIN
			IF LEN(@Name) > @Len
				BEGIN
					SET @Name = RTRIM(LEFT(@Name,@Len))
					SET @ErrorText = 'Принудительно уменьшина длинна Наименования'
					EXEC	[dbo].[usp_TreeNSI_serv_WriteErrorLog]	@isFatalError = 0, @text = @ErrorText,	@user = @user,	@directoryType = @directoryType, @idElement = NULL,	@ErrorSource = @IdProcedure, @Parameters = @parameters
				END
		END

	--Проверка полного наименования
	SET @Len = (SELECT col.max_length
				FROM [sys].[all_columns] col
				JOIN [sys].[tables] t ON t.object_id = col.object_id
				JOIN TreeNSI_DirectoryType DT ON (DT.TableName+'Property') = t.name AND DT.IdDirectoryType = @DirectoryType
				WHERE col.name = 'FullName') 

	IF @Len IS NULL --нет такого столбца
		BEGIN
			SET @ErrorText = 'Поле "FullName" отсутствует в таблице справочника'
			EXEC	[dbo].[usp_TreeNSI_serv_WriteErrorLog]	@isFatalError = 1, @text = @ErrorText,	@user = @user,	@directoryType = @directoryType, @idElement = NULL,	@ErrorSource = @IdProcedure, @Parameters = @parameters

			RETURN
		END
	ELSE
		BEGIN
			IF LEN(@FullName) > @Len
				BEGIN
					SET @FullName = RTRIM(LEFT(@FullName,@Len))
					SET @ErrorText = 'Принудительно уменьшина длинна Полного наименования'
					EXEC	[dbo].[usp_TreeNSI_serv_WriteErrorLog]	@isFatalError = 0, @text = @ErrorText,	@user = @user,	@directoryType = @directoryType, @idElement = NULL,	@ErrorSource = @IdProcedure, @Parameters = @parameters
				END
		END

	--Попытка регистрации в каталоге
	DECLARE @idCatalog INT, @DateRegistration DATETIME
	BEGIN TRANSACTION
	BEGIN TRY
		--BEGIN TRANSACTION
			EXEC	[dbo].[usp_TreeNSI_DirectoryRegistration]
				@directoryType = @directoryType,
				@user = @user,
				@returnId = @idCatalog OUTPUT,
				@returnRegistrationDate = @DateRegistration OUTPUT

			--Запись в таблицу 
	
			SET @sqlText = N'
			INSERT INTO [dbo].['+(SELECT RTRIM(TableName) FROM TreeNSI_DirectoryType WHERE IdDirectoryType = @DirectoryType)+']
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
				   ,1);
			SET @returnId = CAST(SCOPE_IDENTITY() AS INT)'

			EXECUTE sp_executesql @sqlText, N'@idCatalog INT, @IsGroup INT, @ParentId INT, @Name VARCHAR(300), @returnId INT OUTPUT', @idCatalog = @idCatalog , @IsGroup = @IsGroup, @ParentId = @ParentId, @Name = @Name, @returnId = @returnId OUTPUT

			
	END TRY

	BEGIN CATCH
		IF ISNULL(@idCatalog,-1) = -1
			BEGIN
				ROLLBACK TRANSACTION
				SET @ErrorText = 'Не удалось зарегистрировать новый элемент в каталоге'
				EXEC	[dbo].[usp_TreeNSI_serv_WriteErrorLog]	@isFatalError = 1, @text = @ErrorText,	@user = @user,	@directoryType = @directoryType, @idElement = NULL,	@ErrorSource = @IdProcedure, @Parameters = @parameters

		   
				RETURN
			END

		
		IF @returnId IS NULL OR @returnId = -1
			BEGIN
				ROLLBACK TRANSACTION
				SET @ErrorText = 'Не удалось записать новый элемент '+ LEFT(ERROR_MESSAGE(),CASE WHEN LEN(ERROR_MESSAGE())> 945 THEN 945 ELSE LEN(ERROR_MESSAGE()) END)
				EXEC	[dbo].[usp_TreeNSI_serv_WriteErrorLog]	@isFatalError = 1, @text = @ErrorText,	@user = @user,	@directoryType = @directoryType, @idElement = NULL,	@ErrorSource = @IdProcedure, @Parameters = @parameters

				SET @returnId = -1
	
				RETURN
			END
	END CATCH
	
	--Попытка записать полное наименование--
	IF LEN(@FullName) >= LEN(@Name) AND ISNUMERIC(@FullName) = 0 
		BEGIN
			SET @sqlText = N'
			INSERT INTO [dbo].['+(SELECT RTRIM(TableName) FROM TreeNSI_DirectoryType WHERE IdDirectoryType = @DirectoryType)+'Property]
				   ([IdElement]
				   ,[BeginDate]
				   ,[FullName])
			 VALUES
				   (@returnId
				   ,ISNULL(@BeginDate,@DateRegistration)
				   ,@FullName
				   )'
			BEGIN TRY
				EXECUTE sp_executesql @sqlText, N'@returnId INT, @BeginDate DATE, @DateRegistration DATETIME, @FullName VARCHAR(500)', @returnId = @returnId , @BeginDate = @BeginDate, @DateRegistration = @DateRegistration, @FullName = @FullName
			END TRY

			BEGIN CATCH
				BEGIN
					ROLLBACK TRANSACTION
						SET @ErrorText = 'Ошибка при записи периодики '+ LEFT(ISNULL(ERROR_MESSAGE(),''),CASE WHEN LEN(ISNULL(ERROR_MESSAGE(),''))> 945 THEN 945 ELSE LEN(ISNULL(ERROR_MESSAGE(),'')) END)
						EXEC	[dbo].[usp_TreeNSI_serv_WriteErrorLog]	@isFatalError = 1, @text = @ErrorText,	@user = @user,	@directoryType = @directoryType, @idElement = NULL,	@ErrorSource = @IdProcedure, @Parameters = @parameters
						SET @returnId = -1
						RETURN
				END
			END CATCH

		END
	ELSE
		BEGIN

			ROLLBACK TRANSACTION
				SET @ErrorText = 'Теоритически полное наименование не должно быть меньше краткого '
				EXEC	[dbo].[usp_TreeNSI_serv_WriteErrorLog]	@isFatalError = 1, @text = @ErrorText,	@user = @user,	@directoryType = @directoryType, @idElement = NULL,	@ErrorSource = @IdProcedure, @Parameters = @parameters

				SET @returnId = -1
	
				RETURN

		END
	COMMIT TRANSACTION


	
END

GO

DECLARE @result VARCHAR(10) = ' /FAIL'
IF(OBJECT_ID( N'usp_TreeNSI_AddBasePeriodicElement') IS NOT NULL)
	SET @result = ' /OK'
print 'CREATE PROCEDURE [dbo].[usp_TreeNSI_AddBasePeriodicElement]' + @result

/************* Блок описания полей *************/
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Добавление нового периодического элемента в типовой справочник системы TreeNSI' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'usp_TreeNSI_AddBasePeriodicElement'
GO
/************* Конец блока описания полей *************/


print 'END InsertBasePeriodicElementHelper ' + CONVERT(VARCHAR(50) ,GetDATE(), 113 )