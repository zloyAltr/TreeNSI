USE [TreeNSI]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/****************************************************************/
/****************************************************************/
/**        Helper для ввода элемента в справочник Адреса       **/
/****************************************************************/
/****************************************************************/

--***************************************************************--
--**  ДЛЯ КОРРЕКТНОЙ РАБОТЫ НЕОБХОДИМО, ЧТОБЫ COLLATE В ПОЛЯХ  **--
--**       ТАБЛИЦ БЫЛИ ТАКИЕ ЖЕ, КАК ДЛЯ БД В ЦЕЛОМ!!!         **--
--***************************************************************--

--***************************************************************--
--**   ДЛЯ КОРРЕКТНОЙ РАБОТЫ НЕОБХОДИМ ЗАПОЛНЕННЫЙ СПРАВОЧНИК  **--
--**         TreeNSI_Addr_AdministrativTerritorialUnit         **--
--***************************************************************--

--***************************************************************--
--**  ДЛЯ КОРРЕКТНОЙ РАБОТЫ НЕОБХОДИМЫ ЗАПОЛНЕННЫЕ СПРАВОЧНИКИ **--
--** TreeNSI_Addr_AdministrativTerritorialUnit, TreeNSI_Country**--
--***************************************************************--

--****************************************************************--
--**ДЛЯ РЕЗУЛЬТАТИВНОЙ РАБОТЫ НЕОБХОДИМЫ ЗАПОЛНЕННЫЕ СПРАВОЧНИКИ**--
--**         TreeNSI_Addr_AddressesClassifierBY_Locality        **--
--**         TreeNSI_Addr_AddressesClassifierRU_Locality        **--
--****************************************************************--

print 'BEGIN InsertAddressHelper ' + CONVERT(VARCHAR(50) ,GetDATE(), 113 )

IF(OBJECT_ID( N'TreeNSI_Addr_ATUCountryClassifierLocality') IS NULL)
	BEGIN
		CREATE TABLE [dbo].[TreeNSI_Addr_ATUCountryClassifierLocality](
			[IdATU] [int] NOT NULL,
			[IdClassifier] [int] NOT NULL,
			[IdClassifierLocality] [int] NOT NULL,
		 CONSTRAINT [PK_TreeNSI_Addr_ATUCountryClassifierLocality] PRIMARY KEY CLUSTERED 
		(
			[IdATU] ASC,
			[IdClassifier] ASC,
			[IdClassifierLocality] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
		) ON [PRIMARY]

		/************* Блок описания полей *************/

		EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код АТЕ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Addr_ATUCountryClassifierLocality', @level2type=N'COLUMN',@level2name=N'IdATU'


		EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код национального классификатора АТЕ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Addr_ATUCountryClassifierLocality', @level2type=N'COLUMN',@level2name=N'IdClassifier'


		EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код АТЕ в национальном классификаторе' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Addr_ATUCountryClassifierLocality', @level2type=N'COLUMN',@level2name=N'IdClassifierLocality'


		EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Привязка АТЕ к национальным классификаторам' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Addr_ATUCountryClassifierLocality'
		/************* Конец блока описания полей *************/
	END

	DECLARE @result VARCHAR(10) = ' /FAIL'
	IF(OBJECT_ID( N'TreeNSI_Addr_ATUCountryClassifierLocality') IS NOT NULL)
		SET @result = ' /OK'
	print 'CREATE TABLE [dbo].[TreeNSI_Addr_ATUCountryClassifierLocality]' + @result


GO

IF ((SELECT COUNT(*) FROM TreeNSI_Addr_CountryAddressesClassifierLocality) = 0)
	BEGIN
		
		print 'INSERT INTO [TreeNSI_Addr_CountryAddressesClassifierLocality]'

	INSERT INTO [dbo].[TreeNSI_Addr_CountryAddressesClassifierLocality]
           ([IdCountry]
           ,[Name]
           ,[Acronim]
           ,[TableName]
           ,[KeyFieldName])
     VALUES
           (1
           ,'ОКРБ 003-94 "Общегосударственный классификатор "Система обозначений объектов административно-территориального деления и населенных пунктов"'
           ,'СОАТО РБ'
           ,'TreeNSI_Addr_AddressesClassifierBY_Locality'
           ,'IdAddrClassifierBY_Locality')
		   ,(2
           ,'Классификатор адресов Российской Федерации'
           ,'КЛАДР'
           ,'TreeNSI_Addr_AddressesClassifierRU_Locality'
           ,'IdAddrClassifierRU_Locality')
	END
GO

IF(OBJECT_ID( N'udf_TreeNSI_CheckATUCenterLocalityBY') IS NOT NULL)
DROP FUNCTION [dbo].[udf_TreeNSI_CheckATUCenterLocalityBY]
GO

--Проверка, является ли населенный пункт РБ центром административного значения текущего уговня

CREATE FUNCTION [dbo].[udf_TreeNSI_CheckATUCenterLocalityBY]
(--Проверка не точная. Есть ряд исключений: в названиях сельсоветов могут использываться/неиспользоваться составные имена с дефисами, как впрочем, и в их центрах)
@IdClassifierLocality INT -- индификатор АТЕ в справочнике, для котого нужно проверить, является ли он административным центром
)
RETURNS BIT --0- это НЕ административный центр, 1 - административный центр
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
RETURN 0 --ничего не найдено

IF RIGHT(@Code,9) = REPLICATE('0',9)
RETURN 1 --Это Минск

IF @Type IN ('101','102','103','202')
RETURN 0 --Это не населенные пункты

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

/************* Блок описания полей *************/
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Проверка АТЕ на то, что он административный центр в РБ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'FUNCTION',@level1name=N'udf_TreeNSI_CheckATUCenterLocalityBY'
GO
/************* Конец блока описания полей *************/

IF(OBJECT_ID( N'usp_TreeNSI_AddATUFromClassifierLocalityBY') IS NOT NULL)
DROP PROCEDURE [dbo].[usp_TreeNSI_AddATUFromClassifierLocalityBY]
GO

--Процедура добавления нового АТЕ по данным САТАО для РБ

CREATE PROCEDURE [dbo].[usp_TreeNSI_AddATUFromClassifierLocalityBY]
	(
	@IdClassifierLocality INT --Исходное значение
	)

AS
SET NOCOUNT ON
BEGIN
	
	DECLARE @IdATU INT --Возращает код АТЕ (на выходе)
	SET @IdATU = 0 -- Значение по умолчанию, признак неудачи


	--Служебные константы--
	DECLARE @IdProcedure INT         --Системный код процедуры
	SET @IdProcedure =  OBJECT_ID(N'dbo.usp_TreeNSI_AddATUFromClassifierLocalityBY')
	DECLARE @parameters XML          --Входные параметры
	SET @parameters = (SELECT @IdClassifierLocality AS 'IdClassifierLocality' FOR XML RAW) 
	DECLARE @directoryType INT       --Вид справочника
	SET @directoryType = NULL
	DECLARE @ErrorText VARCHAR(1000) --Текст ошибки
	--***********************--

	DECLARE @user INT --Пользователь, который пытается что-то вводить
	SET @user = (SELECT dbo.udf_TreeNSI_GetIdUser())
		
	--Таблица перекодировки типа АТЕ
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
	--,('202',null,0) --Внутригородской район
	,('213',13,0)
	,('221',61,0)
	,('222',15,0)
	,('223',17,0)
	,('231',25,0)
	,('232',29,0)
	,('233',30,0)
	,('234',53,0)
	,('235',60,0)
	--,('239',null,0) --Иное			
	
	DECLARE @ParentCode VARCHAR(10), @ParentIdClassifierLocality INT, @ParentName VARCHAR(300), @ParentIdType INT

	DECLARE @Code VARCHAR(10),
	@IdType INT,
	@Name VARCHAR(300),
	@IsGroup BIT,
	@ParentId INT --код АТЕ родителя (уже записанный)

	DECLARE @KolATU INT --Для поиска непривязанных элементов


	--Опредилим данные по текущету АТЕ
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
			 --данных для создания новой АТЕ недостаточно
			 SET @IdATU = 0

			 SET @ErrorText = 'Не достаточно данных для ввода!'
			 EXEC	[dbo].[usp_TreeNSI_serv_WriteErrorLog]	@isFatalError = 1, @text = @ErrorText,	@user = @user,	@directoryType = @directoryType, @idElement = NULL,	@ErrorSource = @IdProcedure, @Parameters = @parameters
		 
			 RETURN @IdATU
		 END

	 /************Определение родителя*****************/
	 --Определим данные по родителю
	 SET @ParentCode = CASE WHEN RIGHT(@Code,9) = REPLICATE('0',9) THEN NULL
	 WHEN RIGHT(@Code,6) = REPLICATE('0',6) THEN LEFT(@Code,1)+REPLICATE('0',9)
	 WHEN RIGHT(@Code,3) = REPLICATE('0',3) THEN LEFT(@Code,4)+REPLICATE('0',6)
	 ELSE LEFT(@Code,7)+REPLICATE('0',3) END

	 DECLARE @IsCenter BIT --Признак, что АТЕ (неселенный пункт) является административным центром области, района, с/с, а значит его родителем должен быть родитель его "родителя"
	 SET @IsCenter = (SELECT [dbo].[udf_TreeNSI_CheckATUCenterLocalityBY] (@IdClassifierLocality))

	 IF @IsCenter = 1 --Для административных центров родитель будет с кодом следующего уровня
		 SET @ParentCode = CASE WHEN RIGHT(@ParentCode,9) = REPLICATE('0',9) THEN NULL
		 WHEN RIGHT(@ParentCode,6) = REPLICATE('0',6) THEN LEFT(@ParentCode,1)+REPLICATE('0',9)
		 WHEN RIGHT(@ParentCode,3) = REPLICATE('0',3) THEN LEFT(@ParentCode,4)+REPLICATE('0',6)
		 ELSE LEFT(@ParentCode,7)+REPLICATE('0',3) END


	 IF(@ParentCode IS NULL)
		 BEGIN
			 SET @ParentIdClassifierLocality = NULL --это или области или минск
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

			 --Проверка наличия родителя в БД
			SET @ParentId = (SELECT L.IdATU From TreeNSI_Addr_ATUCountryClassifierLocality L
			WHERE L.IdClassifier = 1 AND L.IdClassifierLocality = @ParentIdClassifierLocality)

			IF @ParentId IS NULL
			--нужно вводить родителя (рекруссия этой же процедуры)
			--Он возратит код родителя
				BEGIN
					--С начала нужно проверить есть ли такая АТЕ, введенная вручную
					--

					SET @KolATU =(SELECT COUNT(*) FROM TreeNSI_Addr_AdministrativTerritorialUnit Un
					WHERE NOT EXISTS (SELECT * FROM TreeNSI_Addr_ATUCountryClassifierLocality L
					WHERE L.IdATU = Un.IdATU AND L.IdClassifier = 1)
					AND Un.IdCountry = 1 AND Un.IsGroup = 1 --Проверка ТОЛЬКО наличие родителя (еще можно проверить города, но не более того, так как деревень-однофамильцев черт знает сколько даже в одном районе
					AND LTRIM(Un.Name) = @ParentName)

					IF @KolATU > 1
						BEGIN
							--Это ошибка: Для РБ и РФ задвоение названий без привязки к национальным адресным системам не должно быть!
							
							SET @ParentId = NULL --т.е. в логе будет ошибка, но сам элемент всеже записать нужно!
							SET @ErrorText = 'В БД существуют несколько непривязанных к САТАО записей с наименованием как необходимое: '+ RTRIM(@ParentName)
							 EXEC	[dbo].[usp_TreeNSI_serv_WriteErrorLog]	@isFatalError = 0, @text = @ErrorText,	@user = @user,	@directoryType = @directoryType, @idElement = NULL,	@ErrorSource = @IdProcedure, @Parameters = @parameters
						END
					IF @KolATU = 1 
						BEGIN
							--нужно проставить данные из САТАО и привязать данные
						
									SET @ParentId = (SELECT TOP 1 IdATU FROM TreeNSI_Addr_AdministrativTerritorialUnit Un
										WHERE NOT EXISTS (SELECT * FROM TreeNSI_Addr_ATUCountryClassifierLocality L
										WHERE L.IdATU = Un.IdATU AND L.IdClassifier = 1)
										AND Un.IdCountry = 1 AND Un.IsGroup = 1
										AND LTRIM(Un.Name) = @ParentName)

									--Обновление данных на основании данных СОАТО

									UPDATE TreeNSI_Addr_AdministrativTerritorialUnit
									SET IsGroup = 1,
									Name = @ParentName,
									IdATUType = @ParentIdType,
									IdCountry = 1
									WHERE IdATU = @ParentId

									INSERT INTO TreeNSI_Addr_ATUCountryClassifierLocality
									(IdATU, IdClassifier, IdClassifierLocality)
									VALUES (@ParentId, 1, @ParentIdClassifierLocality)

									--Лог обновления
									SET @ErrorText = 'В БД существует непривязанная к САТАО запись с наименованием как необходимое: '+ RTRIM(@ParentName)+'. Производится обновление данных из САТАО и привязка' 
									 EXEC	[dbo].[usp_TreeNSI_serv_WriteErrorLog]	@isFatalError = 0, @text = @ErrorText,	@user = @user,	@directoryType = @directoryType, @idElement = NULL,	@ErrorSource = @IdProcedure, @Parameters = @parameters

							
						END

					IF @KolATU = 0
						BEGIN
							--рекруссия на саму эту процедуры
							EXEC @ParentId = [dbo].[usp_TreeNSI_AddATUFromClassifierLocalityBY] @IdClassifierLocality = @ParentIdClassifierLocality

							IF @ParentId = 0
								SET @ParentId = NULL
						END

				END
			ELSE
				--Родитель найден, нужна проверка
				BEGIN
					IF NOT EXISTS (SELECT * FROM TreeNSI_Addr_AdministrativTerritorialUnit Un
					WHERE Un.IdATU = @ParentId AND Un.IdATUType = @ParentIdType AND LTRIM(Un.Name) = @ParentName
					AND Un.IdCountry = 1
					AND Un.IsGroup = 1 )
						BEGIN
							--Обновление данных на основании данных СОАТО
							UPDATE TreeNSI_Addr_AdministrativTerritorialUnit
							SET IsGroup = 1,
							Name = @ParentName,
							IdATUType = @ParentIdType,
							IdCountry = 1
							WHERE IdATU = @ParentId

							--Лог обновления
							SET @ErrorText = 'Для группы с кодом ' + CAST(@ParentId AS varchar(10)) + ' обнавлена информация (источник СОАТО РБ)'
							EXEC	[dbo].[usp_TreeNSI_serv_WriteErrorLog]	@isFatalError = 0, @text = @ErrorText,	@user = @user,	@directoryType = @directoryType, @idElement = NULL,	@ErrorSource = @IdProcedure, @Parameters = @parameters
						END

				END

		END

	 /************Конец определения родителя*****************/

	 --Код родителя или определен, или NULL

	--Проверка на наличие не привязанного АТЕ
	--Впроверяем только для тех элементов, которые могут быть группами или являются городами
	SET @KolATU = (SELECT COUNT(*) FROM TreeNSI_Addr_AdministrativTerritorialUnit Un
			--JOIN @T T ON T.IdTYpeATU = Un.IdATUType
			WHERE NOT EXISTS (SELECT * FROM TreeNSI_Addr_ATUCountryClassifierLocality L
			WHERE L.IdATU = Un.IdATU AND L.IdClassifier = 1)
			AND Un.IdCountry = 1 
			AND LTRIM(Un.Name) = @Name
			--AND (T.IsGroup = 1 OR T.IdTYpeATU = 13) --Однофамильцев ищем среди городов и групп
			AND Un.IdATUType IN (5,7,13)
			)

	IF @KolATU = 1 --Есть попадание
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

			--Лог обновления
			SET @ErrorText = 'Обновлены данные для элемента с кодом '+ CAST(@IdATU AS varchar(10))
			 EXEC	[dbo].[usp_TreeNSI_serv_WriteErrorLog]	@isFatalError = 0, @text = @ErrorText,	@user = @user,	@directoryType = @directoryType, @idElement = NULL,	@ErrorSource = @IdProcedure, @Parameters = @parameters
				
			INSERT INTO TreeNSI_Addr_ATUCountryClassifierLocality
					(IdATU, IdClassifier, IdClassifierLocality)
					VALUES (@IdATU, 1, @IdClassifierLocality)

		END

	IF @KolATU > 1
		BEGIN
			--есть несколько непривязанных к САТАО похожих записей
			--Это касяк

			--Лог ошибки...
			SET @ErrorText = 'В БД обнаружено несколько непривязанных к СОАТО записей с требуемым наименованием '+RTRIM(@Name)
			EXEC	[dbo].[usp_TreeNSI_serv_WriteErrorLog]	@isFatalError = 1, @text = @ErrorText,	@user = @user,	@directoryType = @directoryType, @idElement = NULL,	@ErrorSource = @IdProcedure, @Parameters = @parameters

			SET @IdATU = 0
			RETURN @IdATU

		END

	IF @KolATU = 0
		BEGIN

			--ПРоверяем привязан ли объет из классификатора к АТЕ
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
					--Что-то навернулось
					SET @IdATU = 0

					--логирование
					SET @ErrorText = 'Не удалось записать новый АТЕ (из СОАТО) '+ LEFT(ISNULL(ERROR_MESSAGE(),''),CASE WHEN LEN(ISNULL(ERROR_MESSAGE(),''))> 935 THEN 935 ELSE LEN(ISNULL(ERROR_MESSAGE(),'')) END)
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

/************* Блок описания полей *************/
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Добавление нового АТЕ на основании данных СОАТО РБ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'usp_TreeNSI_AddATUFromClassifierLocalityBY'
GO
/************* Конец блока описания полей *************/

IF(OBJECT_ID( N'usp_TreeNSI_AddATUBY') IS NOT NULL)
DROP PROCEDURE [dbo].[usp_TreeNSI_AddATUBY]
GO

--Процедура добавления нового АТЕ для РБ

CREATE PROCEDURE [dbo].[usp_TreeNSI_AddATUBY]
	(
	@ATUName VARCHAR(100),					--Наименование нового АТЕ
	@ATUType INT = NULL ,					--Тип нового АТЕ
	@IdClassifierLocality INT = NULL,		--Код записи в справочнике СОАТО РБ
	
	@LevelATUName0 VARCHAR(100) = NULL,		--Наименование области
	@LevelATUName1 VARCHAR(100) = NULL,		--Наименование района
	@LevelATUName2 VARCHAR(100) = NULL,		--Наименование с/с

	@user INT = NULL						--Код пользователя TreeNSI
	)

AS
SET NOCOUNT ON
BEGIN
	
	DECLARE @IdATU INT --Возращает код АТЕ (на выходе)
	SET @IdATU = 0 -- Значение по умолчанию, признак неудачи


	--Служебные константы--
	DECLARE @IdProcedure INT         --Системный код процедуры
	SET @IdProcedure =  OBJECT_ID(N'dbo.usp_TreeNSI_AddATUBY')
	DECLARE @parameters XML          --Входные параметры
	SET @parameters = (SELECT @ATUName AS 'ATUName', @ATUType AS 'ATUType', @IdClassifierLocality AS 'IdClassifierLocality', @LevelATUName0 AS 'LevelATUName0' , @LevelATUName1 AS 'LevelATUName1', @LevelATUName2 AS 'LevelATUName2', @user AS 'user' FOR XML RAW) 
	DECLARE @directoryType INT       --Вид справочника
	SET @directoryType = NULL
	DECLARE @ErrorText VARCHAR(1000) --Текст ошибки
	--***********************--
	SET @user = ISNULL(@user,(SELECT dbo.udf_TreeNSI_GetIdUser()))
	--Теоритически, пользователь уже должен пройти ряд проверок. Например юрадрес должен заполнять грамотный юзверь, тогда как адреса разгрузки чаще всего будут вводить обезьяны

	--Таблица выбранных данных
	DECLARE @Tab TABLE (id INT, Name VARCHAR(300), Code VARCHAR(10), LocTypeCode VARCHAR(3))
		
	--Таблица перекодировки типа АТЕ
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
	--,('202',null,0) --Внутригородской район
	,('213',13,0)
	,('221',61,0)
	,('222',15,0)
	,('223',17,0)
	,('231',25,0)
	,('232',29,0)
	,('233',30,0)
	,('234',53,0)
	,('235',60,0)
	--,('239',null,0) --Иное			

	IF @IdClassifierLocality IS NOT NULL
		BEGIN
		
			--Есть ссылка на СОАТО.

			EXEC @IdATU = dbo.usp_TreeNSI_AddATUFromClassifierLocalityBY @IdClassifierLocality = @IdClassifierLocality

			RETURN @IdATU 
	END

	IF LEN(RTRIM(@ATUName)) < 2
		BEGIN
			--вывод лога
			SET @ErrorText = 'Недостаточно данных для ввода данных: малое наименование'
			EXEC	[dbo].[usp_TreeNSI_serv_WriteErrorLog]	@isFatalError = 1, @text = @ErrorText,	@user = @user,	@directoryType = @directoryType, @idElement = NULL,	@ErrorSource = @IdProcedure, @Parameters = @parameters

			SET @IdATU = 0
			RETURN @IdATU

		END

	--получение выборки записей 
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

	DECLARE @count INT --Количество полученных записей
	SET @count = (SELECT COUNT(*) FROM @Tab)

	--Ничего не найдено
	IF @count = 0 
		BEGIN 
			--в зависимости от статуса пользователя принимается решение о внесении вручную
			--Пока что выкидываю
			SET @ErrorText = 'В СОАТО такого АТЕ не найдено!'
			EXEC	[dbo].[usp_TreeNSI_serv_WriteErrorLog]	@isFatalError = 1, @text = @ErrorText,	@user = @user,	@directoryType = @directoryType, @idElement = NULL,	@ErrorSource = @IdProcedure, @Parameters = @parameters


			SET @IdATU = 0
			RETURN @IdATU
		END

	--Найдено несколько подобных записей
	IF @count > 1 
		BEGIN
			--уточним критерий поиска через тип АТЕ
			SET @count = (SELECT COUNT(*) FROM @Tab da
			JOIN @T t ON t.Id = da.LocTypeCode
			WHERE 1 = CASE WHEN @ATUType IS NULL THEN 1 ELSE CASE WHEN t.IdTYpeATU = @ATUType THEN 1 ELSE 0 END END)

			IF @count != 1 
					BEGIN
						--однозначно определеить не возможно. Пусть указывают точно
						--Лог
						SET @ErrorText = 'В СОАТО АТЕ с таким наименованием найдено несколько!'
						EXEC	[dbo].[usp_TreeNSI_serv_WriteErrorLog]	@isFatalError = 1, @text = @ErrorText,	@user = @user,	@directoryType = @directoryType, @idElement = NULL,	@ErrorSource = @IdProcedure, @Parameters = @parameters

						SET @IdATU = 0
						RETURN @IdATU

					END
		ELSE
			--Благодоря типу АТЕ удалось подобрать единственую запись
			BEGIN
				SET @IdClassifierLocality = (SELECT da.id FROM @Tab da
				JOIN @T t ON t.Id = da.LocTypeCode
				WHERE 1 = CASE WHEN @ATUType IS NULL THEN 1 ELSE CASE WHEN t.IdTYpeATU = @ATUType THEN 1 ELSE 0 END END)

				--далее идет выполнение процедуры
				--Выполняется процедура usp_TreeNSI_AddATUFromClassifierLocalityBY
				EXEC @IdATU = dbo.usp_TreeNSI_AddATUFromClassifierLocalityBY @IdClassifierLocality = @IdClassifierLocality
	
				RETURN @IdATU

			END

		END

	--Изночально найдена одна запись
	ELSE --IF @count = 1
		BEGIN
			SET @IdClassifierLocality = (SELECT TOP 1 id FROM @Tab)

			--далее идет выполнение процедуры
			--Выполняется процедура usp_TreeNSI_AddATUFromClassifierLocalityBY
			EXEC @IdATU = dbo.usp_TreeNSI_AddATUFromClassifierLocalityBY @IdClassifierLocality = @IdClassifierLocality
	 
			RETURN @IdATU

		END

	RETURN @IdATU

END

DECLARE @result VARCHAR(10) = ' /FAIL'
IF(OBJECT_ID( N'usp_TreeNSI_AddATUBY') IS NOT NULL)
	SET @result = ' /OK'
print 'CREATE PROCEDURE [dbo].[usp_TreeNSI_AddATUBY]' + @result

/************* Блок описания полей *************/
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Добавление нового АТЕ для Республики Беларусь' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'usp_TreeNSI_AddATUBY'
GO
/************* Конец блока описания полей *************/

IF(OBJECT_ID( N'usp_TreeNSI_AddATU') IS NOT NULL)
DROP PROCEDURE [dbo].[usp_TreeNSI_AddATU]
GO

--Процедура добавления нового АТЕ

CREATE PROCEDURE [dbo].[usp_TreeNSI_AddATU]
	(
	@IdCountry INT,							--Страна нового АТЕ
	@ATUName VARCHAR(100),					--Наименование нового АТЕ
	@ATUType INT,							--Тип нового АТЕ
	@LevelsATUData NVARCHAR(1000) = NULL,	-- Данные о выше стоящих уровнях --RAW('LevelATU'), ROOT('LevelsATU')
											--<LevelsATU>
											--	<LevelATU
											--		IdLevel = "..." INT NOT NULL -- Начиная с 0 уровень подчинения (для РБ: 0- область, 1- район, 2- с/с)
											--		IdATU = "..." INT --код уже введенной АТЕ 
											--		Name = "..." VARCHAR(100) --Наименование N-уровня
											--		IdATUType = "..." INT --код типа АТЕ
											--	/>
											--	...
											--	</LevelsATU>

	@user INT = NULL						--Код пользователя TreeNSI
	)

AS
SET NOCOUNT ON
BEGIN
	
	DECLARE @IdATU INT --Возращает код АТЕ (на выходе)
	SET @IdATU = 0 -- Значение по умолчанию, признак неудачи


	--Служебные константы--
	DECLARE @IdProcedure INT         --Системный код процедуры
	SET @IdProcedure =  OBJECT_ID(N'dbo.usp_TreeNSI_AddATU')
	DECLARE @parameters XML          --Входные параметры
	SET @parameters = (SELECT @IdCountry AS 'IdCountry', @ATUName AS 'ATUName', @ATUType AS 'ATUType', @LevelsATUData AS 'LevelsATUData', @user AS 'user' FOR XML RAW) 
	DECLARE @directoryType INT       --Вид справочника
	SET @directoryType = NULL
	DECLARE @ErrorText VARCHAR(1000) --Текст ошибки
	--***********************--
	SET @user = ISNULL(@user,(SELECT dbo.udf_TreeNSI_GetIdUser()))
	--Теоритически, пользователь уже должен пройти ряд проверок. Например юрадрес должен заполнять грамотный юзверь, тогда как адреса разгрузки чаще всего будут вводить обезьяны

	/*********************Начальные проверки*********************/

	IF @IdCountry IS NULL
		BEGIN
			--страна обязательна
			--лог
			SET @ErrorText = 'Недостаточно данных для ввода данных: неуказана страна!'
			EXEC	[dbo].[usp_TreeNSI_serv_WriteErrorLog]	@isFatalError = 1, @text = @ErrorText,	@user = @user,	@directoryType = @directoryType, @idElement = NULL,	@ErrorSource = @IdProcedure, @Parameters = @parameters

			SET @IdATU = 0
			RETURN @IdATU

		END

	IF LEN(ISNULL(@ATUName,'')) = 0
		BEGIN
			--наименование обязательно
			--лог
			SET @ErrorText = 'Недостаточно данных для ввода данных: отсутствует наименование!'
			EXEC	[dbo].[usp_TreeNSI_serv_WriteErrorLog]	@isFatalError = 1, @text = @ErrorText,	@user = @user,	@directoryType = @directoryType, @idElement = NULL,	@ErrorSource = @IdProcedure, @Parameters = @parameters

			SET @IdATU = 0
			RETURN @IdATU

		END

	IF @ATUType IS NOT NULL AND NOT EXISTS (SELECT * FROM TreeNSI_Addr_AdministrativTerritorialUnitType WHERE IdATUType = @ATUType)
		BEGIN
			--кривой тип АТЕ (кривой ввод нужно пресекать!)
			--лог
			SET @ErrorText = 'Недостаточно данных для ввода данных: указанный тип АТЕ отсутствует в БД!'
			EXEC	[dbo].[usp_TreeNSI_serv_WriteErrorLog]	@isFatalError = 1, @text = @ErrorText,	@user = @user,	@directoryType = @directoryType, @idElement = NULL,	@ErrorSource = @IdProcedure, @Parameters = @parameters

			SET @IdATU = 0
			RETURN @IdATU

		END

	IF @IdCountry NOT IN (1,2) AND @ATUType IS NULL
		BEGIN
			--Тип АТЕ обязателен для всех стран, кроме тех, у которых есть в БД национальный реестр адресов
			--лог
			SET @ErrorText = 'Недостаточно данных для ввода данных: отсутствует тип АТЕ!'
			EXEC	[dbo].[usp_TreeNSI_serv_WriteErrorLog]	@isFatalError = 1, @text = @ErrorText,	@user = @user,	@directoryType = @directoryType, @idElement = NULL,	@ErrorSource = @IdProcedure, @Parameters = @parameters

			SET @IdATU = 0
			RETURN @IdATU

		END
	/*********************Конец начальных проверок*********************/

	--Таблица для данных о уровнях подчинения
	DECLARE @t TABLE(id INT IDENTITY(1,1) ,idLevel INT, IdATU INT, Name VARCHAR(100), IdType INT)	

	--Возможно следует все внести в TRY
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

	--Служебные переменные
	DECLARE @x INT, @y INT, @Name VARCHAR(100)

	--Разбор по странам
	IF @IdCountry = 1 --РБ

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

	ELSE IF @IdCountry = 2 --РФ
		BEGIN
			--здесь процедура добавления российских АТЕ
			SET @IdATU = 0 --Пока
			RETURN @IdATU
		END

	ELSE --Все остальные страны
		BEGIN

			DECLARE @tab TABLE (id INT IDENTITY(1,1), IdATU INT, Name VARCHAR(100), IdType INT)

			--Уровень иеархии определяется по региональным настройкам (последний актуальный по юр адресу Или дефалтный)
			--Если он не задан, то по дефолту для типа АТЕ
			--При одиниковых уровнях, полученных из типа АТЕ, последний вид сортировки определяет порядок передачи данных в @LevelsATUData


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

			--После добавления данных на основании типов АТЕ, в @tab заносится и сам будущий элемент 
			--после чего следует проверить от будущего до начального цепочку вхождений 
			--Если IdATU на входе не передается нужно попытаться его определить
			--Если и определить его нельзя этот элемент придется создавать. НО он не должен нарушить общую цепочку подчинения
			--Если же цепочка нарушается, то нельзя давать сохранять все это

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

/************* Блок описания полей *************/
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Добавление нового АТЕ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'usp_TreeNSI_AddATU'
GO
/************* Конец блока описания полей *************/

IF(OBJECT_ID( N'usp_TreeNSI_AddAddress') IS NOT NULL)
DROP PROCEDURE [dbo].[usp_TreeNSI_AddAddress]
GO

--Процедура добавления адреса

CREATE PROCEDURE [dbo].[usp_TreeNSI_AddAddress]
	(
	@IdCountry INT,							--Страна нового АТЕ

	@ATUAddress VARCHAR(100)= NULL,			--Место нахождение объекта в предалах АТЕ
	@PostCode VARCHAR(20) = NULL,			--Почтовый индекс (местного почтового отделения)

	@IdATU INT = NULL,						--Идентификатор АТЕ TreeNSI

	@IdClassifierLocality INT = NULL,		--Идентификатор АТЕ из справочника национального классификатора АТЕ

	@ATUName VARCHAR(100),					--Наименование АТЕ 
	@ATUType INT,							--Тип АТЕ
	@LevelsATUData NVARCHAR(1000) = NULL,	-- Данные о выше стоящих уровнях --RAW('LevelATU'), ROOT('LevelsATU')
											--<LevelsATU>
											--	<LevelATU
											--		IdLevel = "..." INT NOT NULL -- Начиная с 0 уровень подчинения (для РБ: 0- область, 1- район, 2- с/с)
											--		IdATU = "..." INT --код уже введенной АТЕ 
											--		Name = "..." VARCHAR(100) --Наименование N-уровня
											--		IdATUType = "..." INT --код типа АТЕ
											--	/>
											--	...
											--	</LevelsATU>

	@ExtraInfo VARCHAR(100) = NULL,			--Дополнительные сведения (схема подъезда, звонить 2 раза и т.п.)

	@user INT = NULL						--Код пользователя TreeNSI
	)

AS
SET NOCOUNT ON
BEGIN
	
	DECLARE @IdAddress INT --Возращает код адреса на выходе
	SET @IdAddress = 0 -- Значение по умолчанию, признак неудачи


	--Служебные константы--
	DECLARE @IdProcedure INT         --Системный код процедуры
	SET @IdProcedure =  OBJECT_ID(N'dbo.usp_TreeNSI_AddAddress')
	DECLARE @parameters XML          --Входные параметры
	SET @parameters = (SELECT @IdCountry AS 'IdCountry', @ATUAddress AS '@ATUAddress', @PostCode AS 'PostCode', @IdATU AS 'IdATU', @IdClassifierLocality AS 'IdClassifierLocality', @ATUName AS 'ATUName', @ATUType AS 'ATUType', @LevelsATUData AS 'LevelsATUData',@ExtraInfo AS 'ExtraInfo', @user AS 'user' FOR XML RAW) 
	DECLARE @directoryType INT       --Вид справочника
	SET @directoryType = NULL
	DECLARE @ErrorText VARCHAR(1000) --Текст ошибки
	--***********************--
	SET @user = ISNULL(@user,(SELECT dbo.udf_TreeNSI_GetIdUser()))
	--Теоритически, пользователь уже должен пройти ряд проверок. Например юрадрес должен заполнять грамотный юзверь, тогда как адреса разгрузки чаще всего будут вводить обезьяны

	/*********************Начальные проверки*********************/

	IF @IdCountry IS NULL
		BEGIN
			--страна обязательна
			--лог
			SET @ErrorText = 'Недостаточно данных для ввода данных: неуказана страна!'
			EXEC	[dbo].[usp_TreeNSI_serv_WriteErrorLog]	@isFatalError = 1, @text = @ErrorText,	@user = @user,	@directoryType = @directoryType, @idElement = NULL,	@ErrorSource = @IdProcedure, @Parameters = @parameters

			SET @IdAddress = 0
			RETURN @IdAddress

		END

	IF @IdATU IS NULL AND @IdClassifierLocality IS NULL AND LEN(ISNULL(@ATUName,'')) < 2 AND @ATUType IS NULL 
		BEGIN
			--нет данных об АТЕ
			--лог
			SET @ErrorText = 'Недостаточно данных для ввода данных: нет данных об АТЕ!'
			EXEC	[dbo].[usp_TreeNSI_serv_WriteErrorLog]	@isFatalError = 1, @text = @ErrorText,	@user = @user,	@directoryType = @directoryType, @idElement = NULL,	@ErrorSource = @IdProcedure, @Parameters = @parameters

			SET @IdAddress = 0
			RETURN @IdAddress

		END
	/*********************Конец начальных проверок*********************/

	/*********************Служебные переменные**********************/
	DECLARE @sqlText NVARCHAR(max), @_return INT

	IF @IdATU IS NULL
		BEGIN --Определение АТЕ

			IF @IdClassifierLocality IS NOT NULL 
				BEGIN
					--проверка наличия классификатора
					IF NOT EXISTS (SELECT * FROM TreeNSI_Addr_CountryAddressesClassifierLocality WHERE IdCountry = @IdCountry)
						BEGIN
							--При указанной ссылке на национальный классификатор, для страны вводимого адреса не определен национальный классификатор
							--лог
							SET @ErrorText = 'Неопределен АТЕ: при указанной ссылке на национальный классификатор, для страны вводимого адреса не определен национальный классификатор!'
							EXEC	[dbo].[usp_TreeNSI_serv_WriteErrorLog]	@isFatalError = 1, @text = @ErrorText,	@user = @user,	@directoryType = @directoryType, @idElement = NULL,	@ErrorSource = @IdProcedure, @Parameters = @parameters

							SET @IdAddress = 0
							RETURN @IdAddress

						END


				--Проверка существования уазанной ссылке в национальном классификаторе
				SET @_return = 0
				SET @sqlText = N'SELECT @return = COUNT(*) FROM '+ (SELECT TOP 1 TableName FROM TreeNSI_Addr_CountryAddressesClassifierLocality WHERE IdCountry = @IdCountry)
				+ ' WHERE ' + (SELECT TOP 1 KeyFieldName FROM TreeNSI_Addr_CountryAddressesClassifierLocality WHERE IdCountry = @IdCountry) 
				+ ' = @id'

				EXECUTE sp_executesql @sqlText, N'@return INT OUTPUT, @id INT', @return = @_return OUTPUT ,@id = @IdClassifierLocality

				IF @_return = 0
					BEGIN
							--При указанной ссылке на национальный классификатор, в национальном классификаторе указанная запись не обнаружена
							--лог
							SET @ErrorText = 'Неопределен АТЕ: при указанной ссылке на национальный классификатор, в национальном классификаторе указанная запись не обнаружена!'
							EXEC	[dbo].[usp_TreeNSI_serv_WriteErrorLog]	@isFatalError = 1, @text = @ErrorText,	@user = @user,	@directoryType = @directoryType, @idElement = NULL,	@ErrorSource = @IdProcedure, @Parameters = @parameters

							SET @IdAddress = 0
							RETURN @IdAddress

					END

				--В зависимости от страны проводим попытку получить @IdATU
				IF @IdCountry = 1 -- РБ
					BEGIN

						EXEC @IdATU = [dbo].[usp_TreeNSI_AddATUFromClassifierLocalityBY] @IdClassifierLocality

					END

				--Общая проверка на полученный АТЕ
				IF @IdATU = 0
					BEGIN
							--По привязке к национальным классификаторам не удалось установить АТЕ
							--лог
							SET @ErrorText = 'Неопределен АТЕ: при указанной ссылке на национальный классификатор, однозначно определить АТЕ неудалось!'
							EXEC	[dbo].[usp_TreeNSI_serv_WriteErrorLog]	@isFatalError = 1, @text = @ErrorText,	@user = @user,	@directoryType = @directoryType, @idElement = NULL,	@ErrorSource = @IdProcedure, @Parameters = @parameters

							SET @IdAddress = 0
							RETURN @IdAddress

					END

				END 
	
			ELSE
				BEGIN
					IF @ATUType IS NULL 
						BEGIN
							--нет данных об АТЕ
							--лог
							SET @ErrorText = 'Недостаточно данных для ввода данных: неуказан тип АТЕ!'
							EXEC	[dbo].[usp_TreeNSI_serv_WriteErrorLog]	@isFatalError = 1, @text = @ErrorText,	@user = @user,	@directoryType = @directoryType, @idElement = NULL,	@ErrorSource = @IdProcedure, @Parameters = @parameters

							SET @IdAddress = 0
							RETURN @IdAddress

						END

					IF @ATUName IS NULL 
						BEGIN
							--нет данных об АТЕ
							--лог
							SET @ErrorText = 'Недостаточно данных для ввода данных: неуказано наименование АТЕ!'
							EXEC	[dbo].[usp_TreeNSI_serv_WriteErrorLog]	@isFatalError = 1, @text = @ErrorText,	@user = @user,	@directoryType = @directoryType, @idElement = NULL,	@ErrorSource = @IdProcedure, @Parameters = @parameters

							SET @IdAddress = 0
							RETURN @IdAddress

						END

					--Пробуем добавить (определить) АТЕ по наименованию и типу...

					EXEC @IdATU = [dbo].[usp_TreeNSI_AddATU] @IdCountry, @ATUName, @ATUType, @LevelsATUData, @user

					--Общая проверка на полученный АТЕ
					IF @IdATU = 0
						BEGIN
								--По наименованию и типу установить АТЕ не удалось
								--лог
								SET @ErrorText = 'Неопределен АТЕ: По наименованию и типу установить АТЕ неудалось!'
								EXEC	[dbo].[usp_TreeNSI_serv_WriteErrorLog]	@isFatalError = 1, @text = @ErrorText,	@user = @user,	@directoryType = @directoryType, @idElement = NULL,	@ErrorSource = @IdProcedure, @Parameters = @parameters

								SET @IdAddress = 0
								RETURN @IdAddress

						END

				END
		END --Конец определения АТЕ

	--АТЕ должен быть определен к данному моменту

	--1. проводим анализ, вдруг такой адрес уже есть
	IF EXISTS (SELECT * FROM TreeNSI_Addr_Address
	WHERE IdCountry = @IdCountry
	AND IdATU = @IdATU
	AND REPLACE(ISNULL([dbo].[udf_TreeNSI_ATUAddressTrim](@IdCountry,@IdATU,@ATUAddress),'')+'^'+RTRIM(ISNULL(@PostCode,''))+'^'+ISNULL([dbo].[udf_TreeNSI_ATUAddressTrim](@IdCountry,@IdATU,@ExtraInfo),''),' ','')
	= REPLACE(ISNULL([dbo].[udf_TreeNSI_ATUAddressTrim](@IdCountry,@IdATU,ATUAddress),'')+'^'+RTRIM(ISNULL(PostCode,''))+'^'+ISNULL([dbo].[udf_TreeNSI_ATUAddressTrim](@IdCountry,@IdATU,ExtraInfo),''),' ','')
	)
		BEGIN
			--Это дублирущая запись
			--лог
			SET @ErrorText = 'В БД уже существует подобный адрес'
			EXEC	[dbo].[usp_TreeNSI_serv_WriteErrorLog]	@isFatalError = 0, @text = @ErrorText,	@user = @user,	@directoryType = @directoryType, @idElement = NULL,	@ErrorSource = @IdProcedure, @Parameters = @parameters

			SET @IdAddress = (SELECT TOP 1 IdAddress FROM TreeNSI_Addr_Address
								WHERE IdCountry = @IdCountry
								AND IdATU = @IdATU
								AND REPLACE(ISNULL([dbo].[udf_TreeNSI_ATUAddressTrim](@IdCountry,@IdATU,@ATUAddress),'')+'^'+RTRIM(ISNULL(@PostCode,''))+'^'+ISNULL([dbo].[udf_TreeNSI_ATUAddressTrim](@IdCountry,@IdATU,@ExtraInfo),''),' ','')
								= REPLACE(ISNULL([dbo].[udf_TreeNSI_ATUAddressTrim](@IdCountry,@IdATU,ATUAddress),'')+'^'+RTRIM(ISNULL(PostCode,''))+'^'+ISNULL([dbo].[udf_TreeNSI_ATUAddressTrim](@IdCountry,@IdATU,ExtraInfo),''),' ','')
								ORDER BY IsActive DESC)
			RETURN @IdAddress

		END

	--Пробуем записать
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
			--Что-то навернулось
			SET @IdAddress = 0

			--логирование
			SET @ErrorText = 'Не удалось записать новый адрес '+ LEFT(ISNULL(ERROR_MESSAGE(),''),CASE WHEN LEN(ISNULL(ERROR_MESSAGE(),''))> 935 THEN 935 ELSE LEN(ISNULL(ERROR_MESSAGE(),'')) END)
			EXEC	[dbo].[usp_TreeNSI_serv_WriteErrorLog]	@isFatalError = 1, @text = @ErrorText,	@user = @user,	@directoryType = @directoryType, @idElement = NULL,	@ErrorSource = @IdProcedure, @Parameters = @parameters

		END

	RETURN @IdAddress


END
GO

DECLARE @result VARCHAR(10) = ' /FAIL'
IF(OBJECT_ID( N'usp_TreeNSI_AddAddress') IS NOT NULL)
	SET @result = ' /OK'
print 'CREATE PROCEDURE [dbo].[usp_TreeNSI_AddAddress]' + @result

/************* Блок описания полей *************/
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Добавление нового адреса' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'usp_TreeNSI_AddAddress'
GO
/************* Конец блока описания полей *************/

print 'END InsertAddressHelper ' + CONVERT(VARCHAR(50) ,GetDATE(), 113 )

