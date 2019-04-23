USE [TreeNSI]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/****************************************************************/
/****************************************************************/
/**        Стартер для создания необходимых SQL элементов      **/
/**         запускается после первого Debug-bild проекта       **/
/**         переопределяет и создает необходимые объекты       **/
/****************************************************************/
/****************************************************************/

print 'BEGIN FirstStarter ' + CONVERT(VARCHAR(50) ,GetDATE(), 113 )

-- Смена кодировки БД--
-- 
-- Но наиболее лучший вариант, использовать уже настроенный сервер, где в master уже прописано COLLATE Cyrillic_General_CI_AS
-- Предолженный вариант для текущего стартера в припципе подайдет, но гарантировать работу выражения LIKE нельзя:
-- колонки в таблицах останутся в прежней кодировке
IF ((SELECT collation_name  
FROM sys.databases  
WHERE name = N'TreeNSI_test') != 'Cyrillic_General_CI_AS') --Проверка на нужную кодировку
ALTER DATABASE TreeNSI_test  
COLLATE Cyrillic_General_CI_AS --Установка нужной кодировки

GO

/*****************************************/
/**** Основные VIEW нормативных данных ***/
/*****************************************/
IF (EXISTS (SELECT * FROM sys.tables WHERE name = N'view_TreeNSI_Country'))
DROP TABLE [dbo].[view_TreeNSI_Country]

GO

IF(OBJECT_ID( N'view_TreeNSI_Country') IS NOT NULL)
DROP VIEW [dbo].[view_TreeNSI_Country]
GO

--Справочник Страны мира (ОКРБ 017-99)
--МЕТКИ /*; ;*/ НЕ ТРОГАТЬ!!!

CREATE VIEW [dbo].[view_TreeNSI_Country]
AS
/*;START;*/
	WITH prop (IdElement, BeginDate)
		AS
		(
			SELECT IdElement, MAX(BeginDate) FROM TreeNSI_CountryProperty
			/*;@;*/
			GROUP BY IdElement
		)
	SELECT 
			coun.IdCountry,
			coun.Code,
			Property.Name,
			FullName = ISNULL(Property.FullName,Property.Name),
			Property.Alfa2Code,
			Property.Alfa3Code,
			coun.IsActive,
			Property.IsOffshoreArea, 
			Property.BeginDate,
			Property.IdProperty

	FROM TreeNSI_Country coun
	JOIN prop ON prop.IdElement = coun.IdCountry
	JOIN TreeNSI_CountryProperty Property ON Property.IdElement = coun.IdCountry AND Property.BeginDate = prop.BeginDate
/*;END;*/
GO

DECLARE @result VARCHAR(10) = ' /FAIL'
IF(OBJECT_ID( N'view_TreeNSI_Country') IS NOT NULL)
	SET @result = ' /OK'
print 'CREATE VIEW [dbo].[view_TreeNSI_Country]' + @result

/************* Блок описания полей *************/
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_Country', @level2type=N'COLUMN',@level2name=N'IdCountry'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Цифровой код' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_Country', @level2type=N'COLUMN',@level2name=N'Code'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Наименование' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_Country', @level2type=N'COLUMN',@level2name=N'Name'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Полное наименование' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_Country', @level2type=N'COLUMN',@level2name=N'FullName'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Буквенный код альфа-2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_Country', @level2type=N'COLUMN',@level2name=N'Alfa2Code'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Буквенный код альфа-3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_Country', @level2type=N'COLUMN',@level2name=N'Alfa3Code'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Активно' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_Country', @level2type=N'COLUMN',@level2name=N'IsActive'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Офшорная зона' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_Country', @level2type=N'COLUMN',@level2name=N'IsOffshoreArea'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Дата начала действия' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_Country', @level2type=N'COLUMN',@level2name=N'BeginDate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код периодической записи' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_Country', @level2type=N'COLUMN',@level2name=N'IdProperty'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Страны мира' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_Country'
GO

/************* Конец блока описания полей *************/

IF (EXISTS (SELECT * FROM sys.tables WHERE name = N'view_TreeNSI_Currency'))
DROP TABLE [dbo].[view_TreeNSI_Currency]

GO

IF(OBJECT_ID( N'view_TreeNSI_Currency') IS NOT NULL)
DROP VIEW [dbo].[view_TreeNSI_Currency]
GO

--Справочник Валюты (ОКРБ 016-99)
--МЕТКИ /*; ;*/ НЕ ТРОГАТЬ!!!

CREATE VIEW [dbo].[view_TreeNSI_Currency]
AS
/*;START;*/
	WITH prop (IdElement, BeginDate)
		AS
		(
			SELECT IdElement, MAX(BeginDate) FROM TreeNSI_CurrencyProperty
			/*;@;*/
			GROUP BY IdElement
		)
	SELECT 
			curr.IdCurrency,
			curr.Code,
			Property.Name,
			curr.AlfaCode,
			curr.IsActive,
			Property.BeginDate,
			Property.IdProperty

	FROM TreeNSI_Currency curr
	JOIN prop ON prop.IdElement = curr.IdCurrency
	JOIN TreeNSI_CurrencyProperty Property ON Property.IdElement = curr.IdCurrency AND Property.BeginDate = prop.BeginDate
/*;END;*/

GO

DECLARE @result VARCHAR(10) = ' /FAIL'
IF(OBJECT_ID( N'view_TreeNSI_Currency') IS NOT NULL)
	SET @result = ' /OK'
print 'CREATE VIEW [dbo].[view_TreeNSI_Currency]' + @result

/************* Блок описания полей *************/
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_Currency', @level2type=N'COLUMN',@level2name=N'IdCurrency'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Цифровой код' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_Currency', @level2type=N'COLUMN',@level2name=N'Code'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Наименование' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_Currency', @level2type=N'COLUMN',@level2name=N'Name'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Буквенный код' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_Currency', @level2type=N'COLUMN',@level2name=N'AlfaCode'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Активно' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_Currency', @level2type=N'COLUMN',@level2name=N'IsActive'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Дата начала действия' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_Currency', @level2type=N'COLUMN',@level2name=N'BeginDate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код периодической записи' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_Currency', @level2type=N'COLUMN',@level2name=N'IdProperty'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Валюты (ОКРБ 016-99)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_Currency'
GO
/************* Конец блока описания полей *************/

IF (EXISTS (SELECT * FROM sys.tables WHERE name = N'view_TreeNSI_EAEUCommonCustomsTariff'))
DROP TABLE [dbo].[view_TreeNSI_EAEUCommonCustomsTariff]

GO

IF(OBJECT_ID( N'view_TreeNSI_EAEUCommonCustomsTariff') IS NOT NULL)
DROP VIEW [dbo].[view_TreeNSI_EAEUCommonCustomsTariff]
GO

--Справочник Единый таможенный тариф Евразийского экономического союза

CREATE VIEW [dbo].[view_TreeNSI_EAEUCommonCustomsTariff]
AS

	WITH gr (id, name, code)
		AS
		(
			SELECT IdCommonCustomsTariff, CAST(Name AS VARCHAR(1000)), Code FROM TreeNSI_EAEUCommonCustomsTariff
			WHERE IsGroup = 1 AND (Code IS NOT NULL OR ParentId IS NULL)
			UNION ALL
			SELECT IdCommonCustomsTariff, Name = CAST(RTRIM(gr.name) + '->' + RTRIM(t.Name) AS VARCHAR(1000)), gr.code FROM TreeNSI_EAEUCommonCustomsTariff t
			JOIN gr ON gr.id = t.ParentId
			WHERE t.IsGroup = 1 AND t.Code IS NULL
		)
	SELECT 
		tariff.IdCommonCustomsTariff,
		tariff.Code,
		tariff.Name,
		ParentCode = gr.code,
		ParentName = gr.name,
		tariff.AdditionalMeasurementUnit,
		tariff.DutyRate,
		tariff.IsActive,
		tariff.IsGroup,
		tariff.ParentId	
	FROM TreeNSI_EAEUCommonCustomsTariff tariff
	LEFT JOIN gr ON gr.id = tariff.ParentId

GO

DECLARE @result VARCHAR(10) = ' /FAIL'
IF(OBJECT_ID( N'view_TreeNSI_EAEUCommonCustomsTariff') IS NOT NULL)
	SET @result = ' /OK'
print 'CREATE VIEW [dbo].[view_TreeNSI_EAEUCommonCustomsTariff]' + @result

/************* Блок описания полей *************/
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_EAEUCommonCustomsTariff', @level2type=N'COLUMN',@level2name=N'IdCommonCustomsTariff'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код ТН ВЭД' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_EAEUCommonCustomsTariff', @level2type=N'COLUMN',@level2name=N'Code'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Наименование' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_EAEUCommonCustomsTariff', @level2type=N'COLUMN',@level2name=N'Name'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код ТН ВЭД родительской группы' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_EAEUCommonCustomsTariff', @level2type=N'COLUMN',@level2name=N'ParentCode'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Наименование родительской группы' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_EAEUCommonCustomsTariff', @level2type=N'COLUMN',@level2name=N'ParentName'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Доп. ед. изм.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_EAEUCommonCustomsTariff', @level2type=N'COLUMN',@level2name=N'AdditionalMeasurementUnit'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Ставка ввозной таможенной пошлины' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_EAEUCommonCustomsTariff', @level2type=N'COLUMN',@level2name=N'DutyRate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Активно' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_EAEUCommonCustomsTariff', @level2type=N'COLUMN',@level2name=N'IsActive'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Это группа' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_EAEUCommonCustomsTariff', @level2type=N'COLUMN',@level2name=N'IsGroup'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код родительской группы' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_EAEUCommonCustomsTariff', @level2type=N'COLUMN',@level2name=N'ParentId'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Единый таможенный тариф ЕАЭС' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_EAEUCommonCustomsTariff'
GO

/************* Конец блока описания полей *************/

IF (EXISTS (SELECT * FROM sys.tables WHERE name = N'view_TreeNSI_MeasurementUnit'))
DROP TABLE [dbo].[view_TreeNSI_MeasurementUnit]

GO

IF(OBJECT_ID( N'view_TreeNSI_MeasurementUnit') IS NOT NULL)
DROP VIEW [dbo].[view_TreeNSI_MeasurementUnit]
GO

--Справочник Единицы измерения (ОКРБ 008-95)

CREATE VIEW [dbo].[view_TreeNSI_MeasurementUnit]
AS

	WITH gr (id, name)
		AS
		(
			SELECT IdMeasurementUnit, Name FROM TreeNSI_MeasurementUnit
			WHERE IsGroup = 1
		)
	SELECT 
			unit.IdMeasurementUnit,
			Code = CAST(ISNULL(unit.InternationalCode, unit.DomesticCode) AS CHAR(3)),
			unit.Name,
			unit.DomesticIdentificationCode,
			unit.InternationalIdentificationCode,
			unit.[Description],
			unit.DomesticSymbolCode,
			unit.InternationalSymbolCode,
			unit.IsActive,
			DomesticIdentificationCodeForPrint = CAST(REPLACE(REPLACE(unit.DomesticIdentificationCode,'^3',NCHAR(0179)),'^2',NCHAR(0178)) AS NVARCHAR(30)),
			InternationalIdentificationCodeForPrint = CAST(REPLACE(REPLACE(unit.InternationalIdentificationCode,'^3',NCHAR(0179)),'^2',NCHAR(0178)) AS NVARCHAR(30)),
			unit.InternationalCode,
			unit.IsGroup,
			ParentName = gr.name,
			unit.ParentId
	FROM TreeNSI_MeasurementUnit unit
	JOIN gr ON gr.id = unit.ParentId

GO

DECLARE @result VARCHAR(10) = ' /FAIL'
IF(OBJECT_ID( N'view_TreeNSI_MeasurementUnit') IS NOT NULL)
	SET @result = ' /OK'
print 'CREATE VIEW [dbo].[view_TreeNSI_MeasurementUnit]' + @result

/************* Блок описания полей *************/
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_MeasurementUnit', @level2type=N'COLUMN',@level2name=N'IdMeasurementUnit'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Цифровой код' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_MeasurementUnit', @level2type=N'COLUMN',@level2name=N'Code'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Наименование' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_MeasurementUnit', @level2type=N'COLUMN',@level2name=N'Name'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Национальное условное обозначение' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_MeasurementUnit', @level2type=N'COLUMN',@level2name=N'DomesticIdentificationCode'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Международное условное обозначение' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_MeasurementUnit', @level2type=N'COLUMN',@level2name=N'InternationalIdentificationCode'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Описание' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_MeasurementUnit', @level2type=N'COLUMN',@level2name=N'Description'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Национальное кодовое буквенное обозначение' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_MeasurementUnit', @level2type=N'COLUMN',@level2name=N'DomesticSymbolCode'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Международное кодовое буквенное обозначение' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_MeasurementUnit', @level2type=N'COLUMN',@level2name=N'InternationalSymbolCode'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Активно' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_MeasurementUnit', @level2type=N'COLUMN',@level2name=N'IsActive'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Национальное условное обозначение для печати' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_MeasurementUnit', @level2type=N'COLUMN',@level2name=N'DomesticIdentificationCodeForPrint'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Международное условное обозначение для печати' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_MeasurementUnit', @level2type=N'COLUMN',@level2name=N'InternationalIdentificationCodeForPrint'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Международный код' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_MeasurementUnit', @level2type=N'COLUMN',@level2name=N'InternationalCode'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Это группа' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_MeasurementUnit', @level2type=N'COLUMN',@level2name=N'IsGroup'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Наименование родительской группы' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_MeasurementUnit', @level2type=N'COLUMN',@level2name=N'ParentName'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код родительской группы' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_MeasurementUnit', @level2type=N'COLUMN',@level2name=N'ParentId'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Единицы измерения и счета' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_MeasurementUnit'
GO

/************* Конец блока описания полей *************/

/*****************************************/
/****** VIEW данных ОСЖД ******/
/*****************************************/

IF (EXISTS (SELECT * FROM sys.tables WHERE name = N'view_TreeNSI_RailwayCountry'))
DROP TABLE [dbo].[view_TreeNSI_RailwayCountry]

GO

IF(OBJECT_ID( N'view_TreeNSI_RailwayCountry') IS NOT NULL)
DROP VIEW [dbo].[view_TreeNSI_RailwayCountry]
GO

--Справочник Страны участницы ОСЖД
--МЕТКИ /*; ;*/ НЕ ТРОГАТЬ!!!

CREATE VIEW [dbo].[view_TreeNSI_RailwayCountry]
AS
/*;START;*/
	WITH prop (IdElement, BeginDate)
		AS
		(
			SELECT IdElement, MAX(BeginDate) FROM TreeNSI_RailwayCountryProperty
			/*;@;*/
			GROUP BY IdElement
		)
	SELECT 
			Rcoun.IdRailwayCountry,
			Rcoun.Code,
			CountryName = ctr.Name,
			CountryAlfa2Code = ctr.Alfa2Code,
			ContinentCode = Rcoun.ContinentCode,

			Property.RICS,
			Property.RailwayShortName,
			Property.RailwayShortNameTranslit,
			Property.RailwayFullName,

			Rcoun.IsActive,
			Rcoun.IdCountry, 
			Property.BeginDate,
			Property.IdProperty

	FROM TreeNSI_RailwayCountry Rcoun
	LEFT JOIN prop ON prop.IdElement = Rcoun.IdRailwayCountry
	LEFT JOIN TreeNSI_RailwayCountryProperty Property ON Property.IdElement = Rcoun.IdRailwayCountry AND Property.BeginDate = prop.BeginDate
	JOIN view_TreeNSI_Country ctr ON ctr.IdCountry = Rcoun.IdCountry
/*;END;*/

GO

DECLARE @result VARCHAR(10) = ' /FAIL'
IF(OBJECT_ID( N'view_TreeNSI_RailwayCountry') IS NOT NULL)
	SET @result = ' /OK'
print 'CREATE VIEW [dbo].[view_TreeNSI_RailwayCountry]' + @result

/************* Блок описания полей *************/
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_RailwayCountry', @level2type=N'COLUMN',@level2name=N'IdRailwayCountry'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'ЖД код страны' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_RailwayCountry', @level2type=N'COLUMN',@level2name=N'Code'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Страна' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_RailwayCountry', @level2type=N'COLUMN',@level2name=N'CountryName'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Буквенный код страны альфа-2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_RailwayCountry', @level2type=N'COLUMN',@level2name=N'CountryAlfa2Code'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код континента' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_RailwayCountry', @level2type=N'COLUMN',@level2name=N'ContinentCode'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код ЖД предприятия' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_RailwayCountry', @level2type=N'COLUMN',@level2name=N'RICS'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Сокращенное наименование ЖД на русском языке' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_RailwayCountry', @level2type=N'COLUMN',@level2name=N'RailwayShortName'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Сокращенное наименование ЖД (транслитерация)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_RailwayCountry', @level2type=N'COLUMN',@level2name=N'RailwayShortNameTranslit'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Полное наименование ЖД на русском языке' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_RailwayCountry', @level2type=N'COLUMN',@level2name=N'RailwayFullName'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Активно' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_RailwayCountry', @level2type=N'COLUMN',@level2name=N'IsActive'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Индетификатор страны' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_RailwayCountry', @level2type=N'COLUMN',@level2name=N'IdCountry'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Дата начала действия' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_RailwayCountry', @level2type=N'COLUMN',@level2name=N'BeginDate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код периодической записи' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_RailwayCountry', @level2type=N'COLUMN',@level2name=N'IdProperty'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Страны участницы ОСЖД' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_RailwayCountry'
GO
/************* Конец блока описания полей *************/

IF (EXISTS (SELECT * FROM sys.tables WHERE name = N'view_TreeNSI_RailwayStantion'))
DROP TABLE [dbo].[view_TreeNSI_RailwayStantion]

GO

IF(OBJECT_ID( N'view_TreeNSI_RailwayStantion') IS NOT NULL)
DROP VIEW [dbo].[view_TreeNSI_RailwayStantion]
GO

--Справочник Грузовые ЖД станции

CREATE VIEW [dbo].[view_TreeNSI_RailwayStantion]
AS
SELECT  st.[IdRailwayStantion]
	  ,CountryAlfa2Code = co.Alfa2Code
	  ,CountryName = co.Name
	  ,RailwayCountryCode = c.Code
      ,st.[Code]
	  ,st.[BorderPointCode]
      ,st.[Name]
      ,st.[IsActive]
	  ,st.[IdRailwayCountry]
	  ,c.IdCountry
      
  FROM [dbo].[TreeNSI_RailwayStantion] st
  left join TreeNSI_RailwayCountry c On c.IdRailwayCountry = st.IdRailwayCountry
  LEFT JOIN view_TreeNSI_Country co ON co.IdCountry = c.IdCountry

GO

DECLARE @result VARCHAR(10) = ' /FAIL'
IF(OBJECT_ID( N'view_TreeNSI_RailwayStantion') IS NOT NULL)
	SET @result = ' /OK'
print 'CREATE VIEW [dbo].[view_TreeNSI_RailwayStantion]' + @result

/************* Блок описания полей *************/
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Идентификатор' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_RailwayStantion', @level2type=N'COLUMN',@level2name=N'IdRailwayStantion'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код альфа-2 страны' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_RailwayStantion', @level2type=N'COLUMN',@level2name=N'CountryAlfa2Code'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Страна' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_RailwayStantion', @level2type=N'COLUMN',@level2name=N'CountryName'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'ЖД код страны (IM Code)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_RailwayStantion', @level2type=N'COLUMN',@level2name=N'RailwayCountryCode'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код станции' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_RailwayStantion', @level2type=N'COLUMN',@level2name=N'Code'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код пограничного перехода' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_RailwayStantion', @level2type=N'COLUMN',@level2name=N'BorderPointCode'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Название станции на русском' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_RailwayStantion', @level2type=N'COLUMN',@level2name=N'Name'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Активно' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_RailwayStantion', @level2type=N'COLUMN',@level2name=N'IsActive'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Идентификатор ЖД страны' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_RailwayStantion', @level2type=N'COLUMN',@level2name=N'IdRailwayCountry'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Идентификатор страны' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_RailwayStantion', @level2type=N'COLUMN',@level2name=N'IdCountry'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Грузовые ЖД станции' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_RailwayStantion'
GO
/************* Конец блока описания полей *************/


/*****************************************/
/****** VIEW Прочих классификаторов ******/
/*****************************************/

IF (EXISTS (SELECT * FROM sys.tables WHERE name = N'view_TreeNSI_Addr_AddressesClassifierBY_Locality'))

DROP TABLE [dbo].[view_TreeNSI_Addr_AddressesClassifierBY_Locality]

GO

IF(OBJECT_ID( N'view_TreeNSI_Addr_AddressesClassifierBY_Locality') IS NOT NULL)
DROP VIEW [dbo].[view_TreeNSI_Addr_AddressesClassifierBY_Locality]
GO

--ОКРБ 003-94 "Общегосударственный классификатор "Система обозначений объектов административно-территориального деления и населенных пунктов"
CREATE VIEW [dbo].[view_TreeNSI_Addr_AddressesClassifierBY_Locality]
AS

		
	WITH prop (IdElement, BeginDate)
		AS
		(
			SELECT IdElement, MAX(BeginDate) FROM TreeNSI_Addr_AddressesClassifierBY_LocalityProperty
			GROUP BY IdElement
		)
				
	SELECT 
			Property.Name,
			Property.LocalityType,
			Property.Code,
			Addr.IsActive,
			Property.LocalityTypeCode,
			Property.DistrictName,
			Property.DistrictCode,
			Property.RegionName,
			Property.RegionCode,
			Property.EndDate,

			Addr.[Description],
			
			Addr.IdAddrClassifierBY_Locality,
			Property.BeginDate,
			Property.IdProperty

	FROM TreeNSI_Addr_AddressesClassifierBY_Locality Addr
	JOIN prop ON prop.IdElement = Addr.IdAddrClassifierBY_Locality
	JOIN TreeNSI_Addr_AddressesClassifierBY_LocalityProperty Property ON Property.IdElement = Addr.IdAddrClassifierBY_Locality AND Property.BeginDate = prop.BeginDate
	
	GO

DECLARE @result VARCHAR(10) = ' /FAIL'
IF(OBJECT_ID( N'view_TreeNSI_Addr_AddressesClassifierBY_Locality') IS NOT NULL)
	SET @result = ' /OK'
print 'CREATE VIEW [dbo].[view_TreeNSI_Addr_AddressesClassifierBY_Locality]' + @result

/************* Блок описания полей *************/
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Наименование' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_Addr_AddressesClassifierBY_Locality', @level2type=N'COLUMN',@level2name=N'Name'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Тип населенного пункта' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_Addr_AddressesClassifierBY_Locality', @level2type=N'COLUMN',@level2name=N'LocalityType'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код СОАТО' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_Addr_AddressesClassifierBY_Locality', @level2type=N'COLUMN',@level2name=N'Code'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Активно' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_Addr_AddressesClassifierBY_Locality', @level2type=N'COLUMN',@level2name=N'IsActive'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Шифр типа населенного пункта' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_Addr_AddressesClassifierBY_Locality', @level2type=N'COLUMN',@level2name=N'LocalityTypeCode'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Область' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_Addr_AddressesClassifierBY_Locality', @level2type=N'COLUMN',@level2name=N'DistrictName'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Шифр области' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_Addr_AddressesClassifierBY_Locality', @level2type=N'COLUMN',@level2name=N'DistrictCode'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Район' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_Addr_AddressesClassifierBY_Locality', @level2type=N'COLUMN',@level2name=N'RegionName'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Шифр района' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_Addr_AddressesClassifierBY_Locality', @level2type=N'COLUMN',@level2name=N'RegionCode'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Дата окончания действия значения' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_Addr_AddressesClassifierBY_Locality', @level2type=N'COLUMN',@level2name=N'EndDate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Пояснение' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_Addr_AddressesClassifierBY_Locality', @level2type=N'COLUMN',@level2name=N'Description'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код основной единицы измерения' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_Addr_AddressesClassifierBY_Locality', @level2type=N'COLUMN',@level2name=N'IdAddrClassifierBY_Locality'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Дата начала действия' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_Addr_AddressesClassifierBY_Locality', @level2type=N'COLUMN',@level2name=N'BeginDate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код периодической записи' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_Addr_AddressesClassifierBY_Locality', @level2type=N'COLUMN',@level2name=N'IdProperty'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Населенные пункты РБ (ОКРБ 003-94)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_Addr_AddressesClassifierBY_Locality'
GO
/************* Конец блока описания полей *************/


IF (EXISTS (SELECT * FROM sys.tables WHERE name = N'view_TreeNSI_Addr_AddressesClassifierRU_Locality'))
DROP TABLE [dbo].[view_TreeNSI_Addr_AddressesClassifierRU_Locality]

GO

IF(OBJECT_ID( N'view_TreeNSI_Addr_AddressesClassifierRU_Locality') IS NOT NULL)
DROP VIEW [dbo].[view_TreeNSI_Addr_AddressesClassifierRU_Locality]
GO

--Классификатор адресов Российской Федерации
CREATE VIEW [dbo].[view_TreeNSI_Addr_AddressesClassifierRU_Locality]
AS

		
	WITH prop (IdElement, BeginDate)
		AS
		(
			SELECT IdElement, MAX(BeginDate) FROM TreeNSI_Addr_AddressesClassifierRU_LocalityProperty
			GROUP BY IdElement
		)
		, reg(Code, Name, LocalityType)
		AS
		(
		SELECT LEFT(regProp.Code,2), Name, LocalityType FROM TreeNSI_Addr_AddressesClassifierRU_LocalityProperty regProp
		JOIN prop ON prop.IdElement = regProp.IdElement AND regProp.BeginDate = prop.BeginDate
		WHERE CAST(RIGHT(regProp.Code,9) AS INT) = 0
		GROUP BY LEFT(regProp.Code,2), Name, LocalityType
		) 
		, reg1(Code, Name, LocalityType)
		AS
		(
		SELECT LEFT(regProp.Code,5), Name, LocalityType FROM TreeNSI_Addr_AddressesClassifierRU_LocalityProperty regProp
		JOIN prop ON prop.IdElement = regProp.IdElement AND regProp.BeginDate = prop.BeginDate
		WHERE CAST(RIGHT(regProp.Code,6) AS INT) = 0
		GROUP BY LEFT(regProp.Code,5), Name, LocalityType
		)

		
	SELECT 
			Property.Name,
			Property.LocalityType,
			Property.Code,
			Region0Name = CASE WHEN reg.Code + '000000000' = Property.Code THEN NULL ELSE reg.Name + ' ' + reg.LocalityType END,
			Region1Name = CASE WHEN reg1.Code = reg.Code+'000' THEN NULL ELSE reg1.Name + ' ' + reg1.LocalityType END,
			Addr.IsActive,
			Property.Postcode,
			Property.ARCPSCode,

			Addr.[Description],
			Property.[Version],
			Property.[Status],
			Addr.IdAddrClassifierRU_Locality,
			Property.BeginDate,
			Property.IdProperty

	FROM TreeNSI_Addr_AddressesClassifierRU_Locality Addr
	JOIN prop ON prop.IdElement = Addr.IdAddrClassifierRU_Locality
	JOIN TreeNSI_Addr_AddressesClassifierRU_LocalityProperty Property ON Property.IdElement = Addr.IdAddrClassifierRU_Locality AND Property.BeginDate = prop.BeginDate
	JOIN reg ON LEFT(Property.Code,2) = reg.Code
	JOIN reg1 ON LEFT(Property.Code,5) = reg1.Code

GO

DECLARE @result VARCHAR(10) = ' /FAIL'
IF(OBJECT_ID( N'view_TreeNSI_Addr_AddressesClassifierRU_Locality') IS NOT NULL)
	SET @result = ' /OK'
print 'CREATE VIEW [dbo].[view_TreeNSI_Addr_AddressesClassifierRU_Locality]' + @result

/************* Блок описания полей *************/
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Наименование' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_Addr_AddressesClassifierRU_Locality', @level2type=N'COLUMN',@level2name=N'Name'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Тип населенного пункта' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_Addr_AddressesClassifierRU_Locality', @level2type=N'COLUMN',@level2name=N'LocalityType'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код КЛАДР' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_Addr_AddressesClassifierRU_Locality', @level2type=N'COLUMN',@level2name=N'Code'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Наименование региона РФ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_Addr_AddressesClassifierRU_Locality', @level2type=N'COLUMN',@level2name=N'Region0Name'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Наименование района РФ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_Addr_AddressesClassifierRU_Locality', @level2type=N'COLUMN',@level2name=N'Region1Name'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Активно' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_Addr_AddressesClassifierRU_Locality', @level2type=N'COLUMN',@level2name=N'IsActive'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Почтовый индекс' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_Addr_AddressesClassifierRU_Locality', @level2type=N'COLUMN',@level2name=N'Postcode'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код ОКАТО (Общеросийский классификатор объектов административно-территориального деления)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_Addr_AddressesClassifierRU_Locality', @level2type=N'COLUMN',@level2name=N'ARCPSCode'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Пояснение' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_Addr_AddressesClassifierRU_Locality', @level2type=N'COLUMN',@level2name=N'Description'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Номер версии' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_Addr_AddressesClassifierRU_Locality', @level2type=N'COLUMN',@level2name=N'Version'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Статус объекта (определяет признак центра админитсративно-территориального образования)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_Addr_AddressesClassifierRU_Locality', @level2type=N'COLUMN',@level2name=N'Status'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код основной единицы измерения' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_Addr_AddressesClassifierRU_Locality', @level2type=N'COLUMN',@level2name=N'IdAddrClassifierRU_Locality'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Дата начала действия' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_Addr_AddressesClassifierRU_Locality', @level2type=N'COLUMN',@level2name=N'BeginDate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код периодической записи' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_Addr_AddressesClassifierRU_Locality', @level2type=N'COLUMN',@level2name=N'IdProperty'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Классификатор адресов Российской Федерации (КЛАДР)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_Addr_AddressesClassifierRU_Locality'
GO
/************* Конец блока описания полей *************/

/************* Блок служебных данных ******************/

IF(OBJECT_ID( N'TreeNSI_serv_ErrorLog') IS NOT NULL)
DROP TABLE [dbo].[TreeNSI_serv_ErrorLog]
GO

--Служебный журнал регистрации ошибок
CREATE TABLE [dbo].[TreeNSI_serv_ErrorLog](
	[IdError] [int] IDENTITY(1,1) NOT NULL,
	[ErrorDate] [datetime] NOT NULL,
	[User] [int] NULL,
	[IdDirectoryType] [int] NULL,
	[IdElement] [int] NULL,
	[ErrorSource] [int] NOT NULL,
	[ErrorText] [varchar](1000) NULL,
	[Parameters] [xml] NULL,
	[IsFatalError] [bit] NOT NULL,
 CONSTRAINT [PK_TreeNSI_serv_ErrorLog] PRIMARY KEY CLUSTERED 
(
	[IdError] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

DECLARE @result VARCHAR(10) = ' /FAIL'
IF(OBJECT_ID( N'TreeNSI_serv_ErrorLog') IS NOT NULL)
	SET @result = ' /OK'
print 'CREATE TABLE [dbo].[TreeNSI_serv_ErrorLog]' + @result

/************* Блок описания полей *************/
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_serv_ErrorLog', @level2type=N'COLUMN',@level2name=N'IdError'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Дата и время ошибки' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_serv_ErrorLog', @level2type=N'COLUMN',@level2name=N'ErrorDate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код пользователя' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_serv_ErrorLog', @level2type=N'COLUMN',@level2name=N'User'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код вида справочника' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_serv_ErrorLog', @level2type=N'COLUMN',@level2name=N'IdDirectoryType'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код элемента справочника при удалении или редактировании' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_serv_ErrorLog', @level2type=N'COLUMN',@level2name=N'IdElement'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Системный код процедуры, зафиксировавшей ошибку' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_serv_ErrorLog', @level2type=N'COLUMN',@level2name=N'ErrorSource'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Текст ошибки' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_serv_ErrorLog', @level2type=N'COLUMN',@level2name=N'ErrorText'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Параметры процедуры' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_serv_ErrorLog', @level2type=N'COLUMN',@level2name=N'Parameters'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Это критическая ошибка (работа процедуры завершена)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_serv_ErrorLog', @level2type=N'COLUMN',@level2name=N'IsFatalError'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Лог ошибок при работе процедур со справочниками' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_serv_ErrorLog'
GO

/************* Конец блока описания полей *************/

IF(OBJECT_ID( N'usp_TreeNSI_serv_WriteErrorLog') IS NOT NULL)
DROP PROCEDURE [dbo].[usp_TreeNSI_serv_WriteErrorLog]
GO

--Процедура записи данных об ошибке в лог

CREATE PROCEDURE [dbo].[usp_TreeNSI_serv_WriteErrorLog]
	(
	@isFatalError BIT,             --Флаг критической ошибки (1- процедура была прервана)                
	@text VARCHAR(1000),           --Текст процедуры
	@user INT = NULL,              --Код зарегистрированого пользователя системы
	@directoryType INT = NULL,     --Вид справочника системы TreeNSI
	@idElement INT = NULL,         --Код редактируемого/удаляемого элемента
	@ErrorSource INT = NULL,       --Системный код процедуры, сгенерировавшей ошибку
	@Parameters XML                --Параметры, переданные на вход процедуры, сгенерировавшей ошибку
	)

AS
SET NOCOUNT ON
BEGIN
	
	SET @isFatalError = ISNULL(@isFatalError,1)
	SET @text = ISNULL(@text, 'ТЕКСТ ОШИБКИ НЕ ОПРЕДЕЛЕН!')
	IF @ErrorSource IS NULL
	BEGIN
	INSERT INTO [dbo].[TreeNSI_serv_ErrorLog]
           ([ErrorDate]
           ,[User]
           ,[IdDirectoryType]
           ,[IdElement]
           ,[ErrorSource]
           ,[ErrorText]
           ,[Parameters]
		   ,[IsFatalError])
     VALUES
           (GETDATE()
           ,@user
           ,NULL
           ,NULL
           ,OBJECT_ID(N'dbo.usp_TreeNSI_serv_WriteErrorLog')
           ,'НЕОПРЕДЕЛЕН ИСТОЧНИК ЗАПРОСА НА ПРОТОКОЛИРОВАНИЕ ОШИБКИ!'
           ,(SELECT @isFatalError AS 'isFatalError', @text AS 'text', @user AS 'user', @directoryType AS 'directoryType', @idElement AS 'idElement', @ErrorSource AS 'ErrorSource', @Parameters AS 'Parameters' FOR XML RAW)
		   ,1)
	RETURN -1
	END

	INSERT INTO [dbo].[TreeNSI_serv_ErrorLog]
           ([ErrorDate]
           ,[User]
           ,[IdDirectoryType]
           ,[IdElement]
           ,[ErrorSource]
           ,[ErrorText]
           ,[Parameters]
		   ,[IsFatalError])
     VALUES
           (GETDATE()
           ,@user
           ,@directoryType
           ,@idElement
           ,@ErrorSource
           ,@text
           ,@Parameters
		   ,@isFatalError)
	RETURN 1

	
END
GO

DECLARE @result VARCHAR(10) = ' /FAIL'
IF(OBJECT_ID( N'usp_TreeNSI_serv_WriteErrorLog') IS NOT NULL)
	SET @result = ' /OK'
print 'CREATE PROCEDURE [dbo].[usp_TreeNSI_serv_WriteErrorLog]' + @result

/************* Блок описания полей *************/
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Процедура записи ошибок при выполнении процедур обработки данных в справочниках' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'usp_TreeNSI_serv_WriteErrorLog'
GO

/************* Конец блока описания полей *************/

/*********** Конец блока служебных данных *************/

/************* Блок каталога регистрации *************/


IF(OBJECT_ID( N'udf_TreeNSI_ToStringWithOutZero') IS NOT NULL)
DROP FUNCTION [dbo].[udf_TreeNSI_ToStringWithOutZero]
GO

--Отображение строчного отображения числа с необходимым числом незначущих нулей справа
CREATE FUNCTION [dbo].[udf_TreeNSI_ToStringWithOutZero]
(
@numeric VARCHAR(40),  --Число или строка с отображением числа
@CountZero INT         --Количество нулей после запятой, при отображени числа 0
)
RETURNS VARCHAR(40) -- Возвращет представление переданного числа с отсечением незначущих нулей справа
AS
BEGIN
	
	IF ISNUMERIC(CAST(@numeric AS VARCHAR(40))) = 0
	RETURN NULL

	DECLARE @shablon CHAR(1)
	SET @shablon = SUBSTRING(CAST(1-0.5 AS varchar(3)),2,1)
	
	IF @numeric IS NULL 
	RETURN NULL

	SET @numeric = RTRIM(CAST(@numeric AS VARCHAR(40)))

	SET @CountZero = ISNULL(@CountZero,0)

	IF CHARINDEX(@shablon,@numeric,1) = 0
	RETURN CASE WHEN @CountZero = 0 THEN @numeric ELSE @numeric + @shablon + REPLICATE('0',@CountZero) END

	DECLARE @result VARCHAR(40), @CountBit INT, @Len INT
	;
	WITH ic (name,step,lenName)
	AS
	(SELECT SUBSTRING(@numeric,CHARINDEX(@shablon,@numeric,1)+1,40),0,0
	UNION ALL
	SELECT cast(SUBSTRING(name,1,LEN(name)-1) AS varchar(40)) ,step+1,LEN(name) FROM ic
	WHERE LEN(name)>0 and RIGHT(name,1)='0')

	SELECT @CountBit =max(step) , @len =max(lenName) FROM ic

	SET @result = Left(@numeric,LEN(@numeric)-@CountBit)

	IF(@Len-@CountBit = 0 AND @CountBit > 0)
		BEGIN
			IF @CountZero = 0 
				RETURN REPLACE(@result,@shablon,'')
			ELSE
				RETURN @result + REPLICATE('0',@CountZero)
		END
	ELSE
		IF @CountBit > 0 AND @CountZero > (@Len-@CountBit)
			RETURN @result + REPLICATE('0',@CountZero-(@Len-@CountBit))


	RETURN @result
END
GO

DECLARE @result VARCHAR(10) = ' /FAIL'
IF(OBJECT_ID( N'udf_TreeNSI_ToStringWithOutZero') IS NOT NULL)
	SET @result = ' /OK'
print 'CREATE FUNCTION [dbo].[udf_TreeNSI_ToStringWithOutZero]' + @result

/************* Блок описания полей *************/
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Возращет представление переданного числа с отсечением незначущих нулей справа' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'FUNCTION',@level1name=N'udf_TreeNSI_ToStringWithOutZero'
GO
/************* Конец блока описания полей *************/



DECLARE @firstRun INT = 0
DECLARE @result VARCHAR(10) = ' /FAIL'
IF(OBJECT_ID( N'TreeNSI_DirectoryCatalog') IS NULL)
	BEGIN
		SET @firstRun = 1
		CREATE TABLE [dbo].[TreeNSI_DirectoryCatalog](
			[IdCatalog] [int] IDENTITY(1,1) NOT NULL,
			[IdDirectoryType] [int] NOT NULL,
			[IdAuthor] [int] NOT NULL,
			[RegistrationDate] [datetime] NOT NULL,
		 CONSTRAINT [PK_TreeNSI_DirectoryCatalog] PRIMARY KEY CLUSTERED 
		(
			[IdCatalog] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
		) ON [PRIMARY]

		ALTER TABLE [dbo].[TreeNSI_DirectoryCatalog]  WITH CHECK ADD  CONSTRAINT [FK_TreeNSI_DirectoryCatalog_TreeNSI_DirectoryType] FOREIGN KEY([IdDirectoryType])
		REFERENCES [dbo].[TreeNSI_DirectoryType] ([IdDirectoryType])

		ALTER TABLE [dbo].[TreeNSI_DirectoryCatalog] CHECK CONSTRAINT [FK_TreeNSI_DirectoryCatalog_TreeNSI_DirectoryType]

		
		IF(OBJECT_ID( N'udf_TreeNSI_ToStringWithOutZero') IS NOT NULL)
			SET @result = ' /OK'
		print 'CREATE TABLE [dbo].[TreeNSI_DirectoryCatalog]' + @result
	END

/********** Вставка начальных данных *****************/
IF(@firstRun = 1)
	BEGIN
		INSERT INTO TreeNSI_DirectoryType
				([Name]
			   ,[Description]
			   ,[TableName]
			   ,[IsMultilevel]
			   ,[IsPeriodic]
			   ,[OnlyRegistation]
			   ,[IsBaseStructure])
		 VALUES
				--Порядок добавления строк соответствует const ID_DIRECTORY_TYPE в классах соответствующих сущностей
			   ('Номенклатура'
			   ,'Номенклатура материальных ценностей, продукци, товаров и услуг'
			   ,N'TreeNSI_Nomenclature'
			   ,1 ,1 ,0 ,0),
			   ('Контрагенты'
			   ,'Справочник юридических лиц (организаций и предприятий), выступающих в роли контрагентов'
			   ,N'TreeNSI_Counteragent'
			   ,1 ,1 ,0 ,0),
			   ('Подразделения'
			   ,'Структурные подразделения'
			   ,N'TreeNSI_Subdivision'
			   ,1 ,1 ,0 ,1),
			   ('Установки'
			   ,'Справочник промышленных установок предприятия, резервуарных парков, складов хранения'
			   ,N'TreeNSI_IndustrialUnit'
			   ,1 ,1 ,0 ,1),
			   ('Резервуары, блоки установок'
			   ,'Справочник структурных элементов промышленных установок, резервуаров, емкостей'
			   ,N'TreeNSI_IndustrialUnitModule'
			   ,1 ,1 ,0 ,1),
			   ('Технологические переходы'
			   ,'Справочник технологических переходов (операций), выполняемых на предприятии'
			   ,N'TreeNSI_ProcessingStep'
			   ,1 ,1 ,0 ,1)

		SET @result = ' /FAIL'
		IF (SELECT COUNT(*) FROM TreeNSI_DirectoryType) = 6
			SET @result = ' /OK'
		print 'INSERT INTO TreeNSI_DirectoryType' + @result
	END


/********** Конец вставки начальных данных *****************/


IF (EXISTS (SELECT * FROM sys.tables WHERE name = N'view_TreeNSI_DirectoryItems'))
	BEGIN
		ALTER TABLE [dbo].[TreeNSI_IndustrialProcessesUnitOwner] DROP CONSTRAINT [FK_dbo.TreeNSI_IndustrialProcessesUnitOwner_dbo.view_TreeNSI_DirectoryItems_IdCatalogOwner]

		ALTER TABLE [dbo].[TreeNSI_IndustrialProcessesUnitOwner] DROP CONSTRAINT [FK_dbo.TreeNSI_IndustrialProcessesUnitOwner_dbo.view_TreeNSI_DirectoryItems_IdIndustrialProcessesUnit]

		ALTER TABLE [dbo].[TreeNSI_IndustrialProcessesUnitOwner] DROP CONSTRAINT [FK_dbo.TreeNSI_IndustrialProcessesUnitOwner_dbo.view_TreeNSI_IndustrialProcessesUnit_IdIndustrialProcessesUnit]

		DROP TABLE [dbo].[view_TreeNSI_DirectoryItems]
	END
GO


IF(OBJECT_ID( N'view_TreeNSI_DirectoryItems') IS NOT NULL)
DROP VIEW [dbo].[view_TreeNSI_DirectoryItems]

GO

--Элементы справочников системы TreeNSI--
CREATE VIEW [dbo].[view_TreeNSI_DirectoryItems]
AS

	SELECT 
		IdElement = Nom.IdNomenclature,
		IdCatalog = Nom.IdCatalog,
		Name = RTRIM(Nom.Name) + COALESCE(', '+[dbo].[udf_TreeNSI_ToStringWithOutZero] (Prod.MassVolume,0) + ' '+ Un.DomesticSymbolCode ,''),
		IsGroup = Nom.IsGroup,
		ParentId = NomGr.IdCatalog,
		ParentName = RTRIM(NomGr.Name),
		IdTypeCatalog = 1
	   
  FROM TreeNSI_Nomenclature Nom
  LEFT JOIN TreeNSI_Nomenclature NomGr ON NomGr.IdNomenclature = Nom.ParentId AND NomGr.IsGroup = 1
  LEFT JOIN TreeNSI_NomenclatureProductProperty Prod ON Prod.IdNomenclature = Nom.IdNomenclature
  LEFT JOIN TreeNSI_MeasurementUnit Un ON Un.IdMeasurementUnit = Prod.MassVolumeMeashurementUnit

  UNION ALL

  SELECT 
		IdElement = Cn.IdCounteragent,
		IdCatalog = Cn.IdCatalog,
		Name = RTRIM(Cn.Name),
		IsGroup = Cn.IsGroup,
		ParentId = CnGr.IdCatalog,
		ParentName = RTRIM(CnGr.Name),
		IdTypeCatalog = 2
	   
  FROM TreeNSI_Counteragent Cn
  LEFT JOIN TreeNSI_Counteragent CnGr ON CnGr.IdCounteragent = Cn.ParentId AND CnGr.IsGroup = 1

  UNION ALL
  
  SELECT 
		IdElement = Sub.IdSubdivision,
		IdCatalog = Sub.IdCatalog,
		Name = RTRIM(Sub.Name),
		IsGroup = Sub.IsGroup,
		ParentId = SubGr.IdCatalog,
		ParentName = RTRIM(SubGr.Name),
		IdTypeCatalog = 3
	   
  FROM TreeNSI_Subdivision Sub
  LEFT JOIN TreeNSI_Subdivision SubGr ON SubGr.IdSubdivision = Sub.ParentId AND SubGr.IsGroup = 1

  UNION ALL

  SELECT 
		IdElement = Un.IdIndustrialUnit,
		IdCatalog = Un.IdCatalog,
		Name = RTRIM(Un.Name),
		IsGroup = Un.IsGroup,
		ParentId = UnGr.IdCatalog,
		ParentName = RTRIM(UnGr.Name),
		IdTypeCatalog = 4
	   
  FROM TreeNSI_IndustrialUnit Un
  LEFT JOIN TreeNSI_IndustrialUnit UnGr ON UnGr.IdIndustrialUnit = Un.ParentId AND UnGr.IsGroup = 1

  UNION ALL

  SELECT 
		IdElement = UnM.IdIndustrialUnitModule,
		IdCatalog = UnM.IdCatalog,
		Name = RTRIM(UnM.Name),
		IsGroup = UnM.IsGroup,
		ParentId = UnMGr.IdCatalog,
		ParentName = RTRIM(UnMGr.Name),
		IdTypeCatalog = 5
	   
  FROM TreeNSI_IndustrialUnitModule UnM
  LEFT JOIN TreeNSI_IndustrialUnitModule UnMGr ON UnMGr.IdIndustrialUnitModule = UnM.ParentId AND UnMGr.IsGroup = 1

  UNION ALL

  SELECT 
		IdElement = St.IdProcessingStep,
		IdCatalog = St.IdCatalog,
		Name = RTRIM(St.Name),
		IsGroup = St.IsGroup,
		ParentId = StGr.IdCatalog,
		ParentName = RTRIM(StGr.Name),
		IdTypeCatalog = 6
	   
  FROM TreeNSI_ProcessingStep St
  LEFT JOIN TreeNSI_ProcessingStep StGr ON StGr.IdProcessingStep = St.ParentId AND StGr.IsGroup = 1

GO

DECLARE @result VARCHAR(10) = ' /FAIL'
IF(OBJECT_ID( N'view_TreeNSI_DirectoryItems') IS NOT NULL)
	SET @result = ' /OK'
print 'CREATE VIEW [dbo].[view_TreeNSI_DirectoryItems]' + @result

/************* Блок описания полей *************/
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код элемента' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_DirectoryItems', @level2type=N'COLUMN',@level2name=N'IdElement'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код регистрации' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_DirectoryItems', @level2type=N'COLUMN',@level2name=N'IdCatalog'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Наименование' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_DirectoryItems', @level2type=N'COLUMN',@level2name=N'Name'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Это группа' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_DirectoryItems', @level2type=N'COLUMN',@level2name=N'IsGroup'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код регистрации родительской группы' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_DirectoryItems', @level2type=N'COLUMN',@level2name=N'ParentId'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Родительская группа' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_DirectoryItems', @level2type=N'COLUMN',@level2name=N'ParentName'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Тип справочника' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_DirectoryItems', @level2type=N'COLUMN',@level2name=N'IdTypeCatalog'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Элементы справочников системы TreeNSI' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_DirectoryItems'
GO
/************* Конец блока описания полей *************/

IF (EXISTS (SELECT * FROM sys.tables WHERE name = N'view_TreeNSI_IndustrialProcessesUnit'))
DROP TABLE [dbo].[view_TreeNSI_IndustrialProcessesUnit]

GO

IF(OBJECT_ID( N'view_TreeNSI_IndustrialProcessesUnit') IS NOT NULL)
DROP VIEW [dbo].[view_TreeNSI_IndustrialProcessesUnit]
GO

--Основные единицы Технологического процесса (основные данные, актуальные на текущий момент)
--МЕТКИ /*; ;*/ НЕ ТРОГАТЬ!!!

CREATE VIEW [dbo].[view_TreeNSI_IndustrialProcessesUnit]
AS
/*;START;*/
	WITH prop (IdElement, BeginDate)
		AS
		(
			SELECT IdIndustrialProcessesUnit, MAX(BeginDate) FROM TreeNSI_IndustrialProcessesUnitOwner
			/*;@;*/
			GROUP BY IdIndustrialProcessesUnit
		)
		, grp (id, own,BeginDate)
		AS
		(
		SELECT n.IdIndustrialProcessesUnit, n.IdCatalogOwner, n.BeginDate FROM TreeNSI_IndustrialProcessesUnitOwner n
		JOIN prop ON prop.IdElement = n.IdIndustrialProcessesUnit AND prop.BeginDate = n.BeginDate
		)

	SELECT 
		It.IdCatalog, 
		It.Name, 
		DT.IdDirectoryType, 
		DirectoryTypeName = DT.Name, 
		It.IsGroup, 
		ParentName = ISNULL( Par.Name,It.ParentName), --Здесь делаем временную привязку к вышестоящим элементам приоритетней, чем подчинение внутри справочников
		ParentId = ISNULL( Par.IdCatalog,It.ParentId),
		ParentDirectoryTypeName = ISNULL(DTP.Name,DT.Name ),
		ParentIdDirectoryType = ISNULL(DTP.IdDirectoryType,DT.IdDirectoryType),
		grp.BeginDate,
		IdIndustrialProcessesUnit = grp.id 
	 FROM view_TreeNSI_DirectoryItems It
	JOIN TreeNSI_DirectoryType DT ON DT.IdDirectoryType = It.IdTypeCatalog AND DT.IdDirectoryType IN (2,3,4,5,6)
	LEFT JOIN grp ON grp.id = It.IdCatalog
	LEFT JOIN view_TreeNSI_DirectoryItems Par ON Par.IdCatalog = grp.own
	LEFT JOIN TreeNSI_DirectoryType DTP ON DTP.IdDirectoryType = Par.IdTypeCatalog
	/*;END;*/
GO

DECLARE @result VARCHAR(10) = ' /FAIL'
IF(OBJECT_ID( N'view_TreeNSI_IndustrialProcessesUnit') IS NOT NULL)
	SET @result = ' /OK'
print 'CREATE VIEW [dbo].[view_TreeNSI_IndustrialProcessesUnit]' + @result

/************* Блок описания полей *************/
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код регистрации элемента' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_IndustrialProcessesUnit', @level2type=N'COLUMN',@level2name=N'IdCatalog'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Наименование' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_IndustrialProcessesUnit', @level2type=N'COLUMN',@level2name=N'Name'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код типа элемента' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_IndustrialProcessesUnit', @level2type=N'COLUMN',@level2name=N'IdDirectoryType'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Тип элемента' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_IndustrialProcessesUnit', @level2type=N'COLUMN',@level2name=N'DirectoryTypeName'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Это группа' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_IndustrialProcessesUnit', @level2type=N'COLUMN',@level2name=N'IsGroup'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Наименование родительской группы' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_IndustrialProcessesUnit', @level2type=N'COLUMN',@level2name=N'ParentName'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код элемента-родителя' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_IndustrialProcessesUnit', @level2type=N'COLUMN',@level2name=N'ParentId'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Тип элемента-родителя' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_IndustrialProcessesUnit', @level2type=N'COLUMN',@level2name=N'ParentDirectoryTypeName'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код типа элемента-родителя' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_IndustrialProcessesUnit', @level2type=N'COLUMN',@level2name=N'ParentIdDirectoryType'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Дата начала действия' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_IndustrialProcessesUnit', @level2type=N'COLUMN',@level2name=N'BeginDate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Элементы технологического процесса' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_IndustrialProcessesUnit'
GO

/************* Конец блока описания полей *************/


/************* Блок инструментов регистрации/снятия с регистрации элементов ***************/
IF(OBJECT_ID( N'udf_TreeNSI_GetIdUser') IS NOT NULL)
DROP FUNCTION [dbo].[udf_TreeNSI_GetIdUser]
GO

--Получение кода регистрации пользователя в системе TreeNSI
CREATE FUNCTION [dbo].[udf_TreeNSI_GetIdUser]
(
)
RETURNS INT -- Возращает NULL если пользователь не зарегистрирован как активный пользователь и IdUser, если пользователь числится активным пользователем системы
AS
BEGIN
	
	RETURN (SELECT TOP 1 IdUser FROM TreeNSI_Users WHERE ADName = USER AND IsActive = 1 ORDER BY IdUser DESC)
END
GO

DECLARE @result VARCHAR(10) = ' /FAIL'
IF(OBJECT_ID( N'udf_TreeNSI_GetIdUser') IS NOT NULL)
	SET @result = ' /OK'
print 'CREATE FUNCTION [dbo].[udf_TreeNSI_GetIdUser]' + @result

/************* Блок описания полей *************/
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Получение кода регистрации пользователя в системы TreeNSI' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'FUNCTION',@level1name=N'udf_TreeNSI_GetIdUser'
GO

/************* Конец блока описания полей *************/

IF(OBJECT_ID( N'udf_TreeNSI_serv_CheckUser') IS NOT NULL)
DROP FUNCTION [dbo].[udf_TreeNSI_serv_CheckUser]
GO

--Проверка регистрации пользователя в системе TreeNSI

CREATE FUNCTION [dbo].[udf_TreeNSI_serv_CheckUser]
(
@UserId INT = null --Проверяемый код пользователя
)
RETURNS BIT -- Возращает 1 если пользователь зарегистрирован как активный пользователь
AS
BEGIN
	
	SET @UserId =ISNULL(@UserId,(SELECT TOP 1 IdUser FROM TreeNSI_Users WHERE ADName = USER AND IsActive = 1 ORDER BY IdUser DESC))
	
	RETURN CAST((CASE WHEN @UserId IS NULL OR (SELECT COUNT(*) FROM TreeNSI_Users WHERE IdUser = @UserId AND IsActive = 1) = 0 THEN 0 ELSE 1 END) AS BIT)
END
GO

DECLARE @result VARCHAR(10) = ' /FAIL'
IF(OBJECT_ID( N'udf_TreeNSI_serv_CheckUser') IS NOT NULL)
	SET @result = ' /OK'
print 'CREATE FUNCTION [dbo].[udf_TreeNSI_serv_CheckUser]' + @result

/************* Блок описания полей *************/
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Проверка предналежности пользователя к активным пользователям системы TreeNSI' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'FUNCTION',@level1name=N'udf_TreeNSI_serv_CheckUser'
GO

/************* Конец блока описания полей *************/

IF(OBJECT_ID( N'usp_TreeNSI_DirectoryRegistration') IS NOT NULL)
DROP PROCEDURE [dbo].[usp_TreeNSI_DirectoryRegistration]
GO

--Процедура регистации элемента справочника в Каталоге

CREATE PROCEDURE [dbo].[usp_TreeNSI_DirectoryRegistration]
	(
	@directoryType INT,								-- Тип справочника регистрируемого элемента
	@user INT = NULL,								-- Пользователь, от чего лицаа идет регистрации
	@returnId INT  = NULL OUTPUT,					-- Код регистрации
	@returnRegistrationDate DATETIME  = NULL OUTPUT	-- Дата регистрации
	)

AS
SET NOCOUNT ON
BEGIN
	
	SET @returnId = -1;
	IF @directoryType IS NULL
	RETURN
	
	
	SET @user = ISNULL(@user,(SELECT dbo.udf_TreeNSI_GetIdUser()))
	IF @user IS NULL OR (SELECT dbo.udf_TreeNSI_serv_CheckUser(@user)) = 0
	RETURN
	
	DECLARE @returnDate DATETIME
	SET @returnDate = GETDATE()
	
	IF (SELECT COUNT(*) FROM TreeNSI_DirectoryType WHERE IdDirectoryType = @directoryType) != 1
	RETURN
	
	INSERT INTO dbo.TreeNSI_DirectoryCatalog
	([IdDirectoryType]
     ,[IdAuthor]
     ,[RegistrationDate])
	VALUES
	(@directoryType,@user,@returnDate)
	SET @returnId = (SELECT SCOPE_IDENTITY())
END
GO

DECLARE @result VARCHAR(10) = ' /FAIL'
IF(OBJECT_ID( N'usp_TreeNSI_DirectoryRegistration') IS NOT NULL)
	SET @result = ' /OK'
print 'CREATE PROCEDURE [dbo].[usp_TreeNSI_DirectoryRegistration]' + @result

/************* Блок описания полей *************/
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Регистрация Элемента справочника в каталоге. Возращает код и дату регистрации' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'usp_TreeNSI_DirectoryRegistration'
GO
/************* Конец блока описания полей *************/

IF(OBJECT_ID( N'usp_TreeNSI_CheckReferenceIdCatalog') IS NOT NULL)
DROP PROCEDURE [dbo].[usp_TreeNSI_CheckReferenceIdCatalog]
GO

--Процедура, осуществляющая проверку на использование кода регистрации элемента
CREATE PROCEDURE [dbo].[usp_TreeNSI_CheckReferenceIdCatalog] 
(
	@directoryType INT,							--Тип справочника TreeNSI
	@catalogId INT,								--Код регистрации
	@massage VARCHAR(1000) = NULL OUTPUT		--Текст сообщения с описанием где используется код регистрации
)

AS
SET NOCOUNT ON
BEGIN
	EXECUTE AS CALLER

	IF NOT EXISTS (SELECT * FROM TreeNSI_DirectoryType WHERE IdDirectoryType = @directoryType)
	BEGIN
	SET @massage = NULL
	RETURN 0
	END
	
	/*ТЕКСТ ПРОВЕРОК*/
	IF EXISTS (SELECT IdCatalog FROM view_TreeNSI_DirectoryItems WHERE IdTypeCatalog = @catalogId AND ParentId = @catalogId)
	BEGIN
	SET @massage = 'Элемент с кодом регистрации '+CAST(@catalogId AS varchar(10)) + ' используется как группа в справочнике ' + (SELECT TOP 1 r.Name FROM TreeNSI_DirectoryType r WHERE r.IdDirectoryType = @directoryType)
	RETURN 1
	END

	IF EXISTS (SELECT IdCatalog FROM view_TreeNSI_IndustrialProcessesUnit WHERE ParentId = @catalogId)
	BEGIN
	SET @massage = 'Элемент с кодом регистрации '+CAST(@catalogId AS varchar(10)) + ' используется как группа в сущности "Элементы технологического процесса"'
	RETURN 1
	END

	/*КОНЕЦ ПРОВЕРОК*/

	--Объект на используется
	SET @massage = NULL
	RETURN 0


END
GO

DECLARE @result VARCHAR(10) = ' /FAIL'
IF(OBJECT_ID( N'usp_TreeNSI_CheckReferenceIdCatalog') IS NOT NULL)
	SET @result = ' /OK'
print 'CREATE PROCEDURE [dbo].[usp_TreeNSI_CheckReferenceIdCatalog]' + @result

/************* Блок описания полей *************/
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Процедура, осуществляющая проверку на использование кода регистрации элемента системы TreeNSI' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'usp_TreeNSI_CheckReferenceIdCatalog'
GO

/************* Конец блока описания полей *************/

IF(OBJECT_ID( N'usp_TreeNSI_DirectoryUnRegistration') IS NOT NULL)
DROP PROCEDURE [dbo].[usp_TreeNSI_DirectoryUnRegistration]
GO

--Процедура Снятия с регистрации элемента справочника в Каталоге

CREATE PROCEDURE [dbo].[usp_TreeNSI_DirectoryUnRegistration]
	(
	@directoryType INT,							--Тип справочника
	@catalogId INT,								--Код регистрации
	@user INT = NULL,							--Код пользователя TreeNSI
	@errorMassage VARCHAR(1000) = NULL OUTPUT	--Текст произошедшей ошибки
	)

AS
SET NOCOUNT ON
BEGIN
	
	--Служебные константы--
	DECLARE @IdProcedure INT         --Системный код процедуры
	SET @IdProcedure =  OBJECT_ID(N'dbo.usp_TreeNSI_DirectoryUnRegistration')
	DECLARE @parameters XML          --Входные параметры
	SET @parameters = (SELECT @directoryType AS 'directoryType', @catalogId AS 'catalogId', @user AS 'user' FOR XML RAW) 
	--******************************


	IF @directoryType IS NULL
	BEGIN
	SET @errorMassage = 'Неуказан тип каталога!'
	EXEC	[dbo].[usp_TreeNSI_serv_WriteErrorLog]	@isFatalError = 1, @text = @errorMassage,	@user = @user,	@directoryType = @directoryType, @idElement = NULL,	@ErrorSource = @IdProcedure, @Parameters = @parameters
	RETURN -1
	END

	SET @user = ISNULL(@user,(SELECT dbo.udf_TreeNSI_GetIdUser()))
	IF @user IS NULL OR (SELECT dbo.udf_TreeNSI_serv_CheckUser(@user)) = 0
	BEGIN
	SET @errorMassage = 'Пользователь не зарегестрирован!'
	EXEC	[dbo].[usp_TreeNSI_serv_WriteErrorLog]	@isFatalError = 1, @text = @errorMassage,	@user = @user,	@directoryType = @directoryType, @idElement = NULL,	@ErrorSource = @IdProcedure, @Parameters = @parameters
	RETURN -1
	END
	--*****************************************
	/*ПРОВЕРКА НА ПРАВО СНЯТЬ С РЕГИСТРАЦИИ*/
	--*****************************************
	DECLARE @error VARCHAR(1000), @result INT
		
	IF (SELECT COUNT(*) FROM TreeNSI_DirectoryType WHERE IdDirectoryType = @directoryType) != 1
	BEGIN
	SET @errorMassage = 'Тип каталога не определен!'
	EXEC	[dbo].[usp_TreeNSI_serv_WriteErrorLog]	@isFatalError = 1, @text = @errorMassage,	@user = @user,	@directoryType = @directoryType, @idElement = NULL,	@ErrorSource = @IdProcedure, @Parameters = @parameters
	RETURN -1
	END

	--Проверка на использование в самой TreeNSI
	EXEC @result = [dbo].[usp_TreeNSI_CheckReferenceIdCatalog] 
		@directoryType = @directoryType,
		@catalogId = @catalogId,
		@massage = @error OUTPUT

	IF (@result <> 0 OR LEN(ISNULL(@error ,'')) > 0)
		BEGIN
			SET @errorMassage = 'Элемент с кодом регистрации '+CAST(@catalogId AS varchar(10)) + ' используется в TreeNSI: '+LEFT(RTRIM(ISNULL(@error,'')),CASE WHEN LEN(RTRIM(ISNULL(@error,''))) >900 THEN 900 ELSE LEN(RTRIM(ISNULL(@error,''))) END )
			EXEC	[dbo].[usp_TreeNSI_serv_WriteErrorLog]	@isFatalError = 1, @text = @errorMassage,	@user = @user,	@directoryType = @directoryType, @idElement = NULL,	@ErrorSource = @IdProcedure, @Parameters = @parameters
			RETURN -1

		END

	
	--*****************************************
	/*ПРОВЕРКА НА ИСПОЛЬЗОВАНИЕ В РАЗЛИЧНЫХ СИСТЕМАХ*/

	DECLARE @tab TABLE (id INT IDENTITY, path VARCHAR(100)) --Таблица БД для поиска

	;WITH one (path, ord)
	AS
	(SELECT   
		CASE WHEN CHARINDEX('.',TableName,1) = 0 THEN @@SERVERNAME +'.'+DB_NAME() + '.'+OBJECT_SCHEMA_NAME(OBJECT_ID('TreeNSI_DirectoryType')) +'.'+TableName
		WHEN CHARINDEX('.',TableName,CHARINDEX('.',TableName,CHARINDEX('.',TableName,1)+1)+1) = 0 THEN @@SERVERNAME +'.'+TableName
		WHEN CHARINDEX('.',TableName,CHARINDEX('.',TableName,1)+1) = 0 THEN @@SERVERNAME +'.'+DB_NAME()+'.'+TableName
		ELSE TableName
		END, OnlyRegistation
	FROM TreeNSI_DirectoryType
		UNION ALL
	SELECT
	RTRIM(ServerName)+'.'+RTRIM(DBName) + '.'+RTRIM(SchemaName)+'.',
	2
	FROM TreeNSI_DBUseForeignKey
	)
	INSERT INTO @tab
	SELECT DISTINCT _path = CAST(ord AS varchar(1))+'['+REPLACE(

	REPLACE(REPLACE(
	LEFT(
	LOWER(path),
	CHARINDEX('.',path,CHARINDEX('.',path,CHARINDEX('.',path,1)+1)+1)
	)
	,'[',''),']','')


	,'.','].[') + 'usp_TreeNSI_CheckReferenceIdCatalog]' FROM one

	ORDER BY _path


	UPDATE @tab
	SET path = RIGHT(path,LEN(path)-1)

	;WITH onl (id, path)
	AS
	( SELECT MIN(id), path FROM @tab
	GROUP BY path)
	, forDel (id, pr)
	AS
	(SELECT t.id, onl.id FROM @tab t
	LEFT JOIN onl ON onl.id = t.id AND t.path = onl.path
	)
	DELETE t
	FROM @tab t
	JOIN forDel f ON f.id = t.id AND f.pr IS NULL

	DECLARE @x int, @y int, @path VARCHAR(100)

	SELECT @y =MAX(id) , @x = MIN(id) FROM @tab
	 WHILE @x <= @y --цикл проверки
		 BEGIN

			 SELECT @path = path FROM @tab
			 WHERE id = @x

			 BEGIN TRY

				 EXEC @result = @path
					@directoryType = @directoryType,
					@catalogId = @catalogId,
					@massage = @error OUTPUT

			END TRY

			BEGIN CATCH
				SET @errorMassage = 'Ошибка при проверке испрользования в ' +RTRIM(@path)+ '! '+LEFT(ISNULL(ERROR_MESSAGE(),''),CASE WHEN LEN(ISNULL(ERROR_MESSAGE(),''))> 900 THEN 900 ELSE LEN(ISNULL(ERROR_MESSAGE(),'')) END)
				EXEC	[dbo].[usp_TreeNSI_serv_WriteErrorLog]	@isFatalError = 1, @text = @errorMassage,	@user = @user,	@directoryType = @directoryType, @idElement = NULL,	@ErrorSource = @IdProcedure, @Parameters = @parameters
				RETURN -1
			END CATCH

			IF (@result <> 0 OR LEN(ISNULL(@error ,'')) > 0)
				BEGIN
					SET @errorMassage = 'Элемент с кодом регистрации '+CAST(@catalogId AS varchar(10)) + ' используется в '+ LEFT(@path,CHARINDEX('.',@path,CHARINDEX('.',@path,1)+1)-1)+': '+LEFT(RTRIM(ISNULL(@error,'')),CASE WHEN LEN(RTRIM(ISNULL(@error,''))) >900 THEN 900 ELSE LEN(RTRIM(ISNULL(@error,''))) END )
					EXEC	[dbo].[usp_TreeNSI_serv_WriteErrorLog]	@isFatalError = 1, @text = @errorMassage,	@user = @user,	@directoryType = @directoryType, @idElement = NULL,	@ErrorSource = @IdProcedure, @Parameters = @parameters
					RETURN -1

				END
		

			 SET @x = (SELECT MIN(id) FROM @tab
												WHERE id > @x)
		 END

	/*Конец локальных проверок в различных системах*/
	--*****************************************



	/*НЕПОСРЕДСТВЕННО СНЯТИЕ С РЕГИСТРАЦИИ*/
	DECLARE @countDel INT
	BEGIN TRY

	DELETE FROM TreeNSI_DirectoryCatalog
	WHERE IdCatalog = @catalogId AND IdDirectoryType = @directoryType

	SET @countDel = @@ROWCOUNT

	END TRY

	BEGIN CATCH
	SET @errorMassage = 'Ошибка при отмене регистрации! ' + LEFT(ISNULL(ERROR_MESSAGE(),''),CASE WHEN LEN(ISNULL(ERROR_MESSAGE(),''))> 945 THEN 945 ELSE LEN(ISNULL(ERROR_MESSAGE(),'')) END)
	EXEC	[dbo].[usp_TreeNSI_serv_WriteErrorLog]	@isFatalError = 1, @text = @errorMassage,	@user = @user,	@directoryType = @directoryType, @idElement = NULL,	@ErrorSource = @IdProcedure, @Parameters = @parameters
	RETURN -1
	END CATCH

	IF @countDel = 0
	BEGIN
	SET @errorMassage = 'Элемент типа '+ CAST(@directoryType AS varchar(10))+' и кодом регистрации '+CAST(@catalogId AS varchar(10))+' в каталоге не найден!'
	EXEC	[dbo].[usp_TreeNSI_serv_WriteErrorLog]	@isFatalError = 0, @text = @errorMassage,	@user = @user,	@directoryType = @directoryType, @idElement = NULL,	@ErrorSource = @IdProcedure, @Parameters = @parameters
	SET @errorMassage = NULL
	RETURN 1

	END


	/*ВОЗВРАТ ПРИ УСПЕШНОМ ВЫПОЛНЕНИИ СНЯТИЕ С РЕГИСТРАЦИИ*/
	SET @errorMassage = NULL
	RETURN 0

	
END
GO

DECLARE @result VARCHAR(10) = ' /FAIL'
IF(OBJECT_ID( N'usp_TreeNSI_DirectoryUnRegistration') IS NOT NULL)
	SET @result = ' /OK'
print 'CREATE PROCEDURE [dbo].[usp_TreeNSI_DirectoryUnRegistration]' + @result

/************* Блок описания полей *************/
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Снатие с регистрации элемента справочника. Возращает текст ошибки при неудачи' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'usp_TreeNSI_DirectoryUnRegistration'
GO
/************* Конец блока описания полей *************/

/*********** Конец блока инструментов регистрации/снятия с регистрации элементов **********/
/********** Конец блока каталога регистрации *********/

/************* Блок представлений основных регистрируемых справочников *******************/

IF (EXISTS (SELECT * FROM sys.tables WHERE name = N'view_TreeNSI_Nomenclature'))
DROP TABLE [dbo].[view_TreeNSI_Nomenclature]

GO

IF(OBJECT_ID( N'view_TreeNSI_Nomenclature') IS NOT NULL)
DROP VIEW [dbo].[view_TreeNSI_Nomenclature]
GO

--Справочник Номенклатура (основные данные, актуальные на текущий момент)
--МЕТКИ /*; ;*/ НЕ ТРОГАТЬ!!!

CREATE VIEW [dbo].[view_TreeNSI_Nomenclature]
AS
/*;START;*/
	WITH prop (IdElement, BeginDate)
		AS
		(
			SELECT IdElement, MAX(BeginDate) FROM TreeNSI_NomenclatureProperty
			/*;@;*/
			GROUP BY IdElement
		)
		, grp (id, name)
		AS
		(
		SELECT IdNomenclature, Property.FullName FROM TreeNSI_Nomenclature n
		JOIN prop ON prop.IdElement = n.IdNomenclature
		JOIN TreeNSI_NomenclatureProperty Property ON Property.IdElement = n.IdNomenclature AND Property.BeginDate = prop.BeginDate
		WHERE IsGroup = 1
		)
	SELECT 
			nom.IdNomenclature,
			Name = nom.Name + COALESCE(', '+[dbo].[udf_TreeNSI_ToStringWithOutZero] (Prod.MassVolume,0) + ' '+ Un.DomesticSymbolCode ,''),
			FullName = Property.FullName + COALESCE(', '+[dbo].[udf_TreeNSI_ToStringWithOutZero] (Prod.MassVolume,0) + ' '+ Un.DomesticSymbolCode ,''),
			nom.IsGroup,
			nom.IsActive,
			ParentFulName = grp.name,
			BaseMeasurementUnitDomIdentCode = baseMU.DomesticIdentificationCode,

			nom.IdCatalog,
			nom.ParentId,
			Property.BeginDate,
			Property.IdProperty,
			IdBaseMeasurementUnit = nomMU.IdMeasurementUnit

	FROM TreeNSI_Nomenclature nom
	JOIN prop ON prop.IdElement = nom.IdNomenclature
	JOIN TreeNSI_NomenclatureProperty Property ON Property.IdElement = nom.IdNomenclature AND Property.BeginDate = prop.BeginDate
	LEFT JOIN grp ON grp.id = nom.ParentId
	LEFT JOIN TreeNSI_NomenclatureMeasurementUnit nomMU ON nomMU.IdNomenclature = nom.IdNomenclature AND nomMU.IsBaseUnit = 1
	LEFT JOIN TreeNSI_MeasurementUnit baseMU ON nomMU.IdMeasurementUnit = baseMU.IdMeasurementUnit
	LEFT JOIN TreeNSI_NomenclatureProductProperty Prod ON Prod.IdNomenclature = Nom.IdNomenclature
    LEFT JOIN TreeNSI_MeasurementUnit Un ON Un.IdMeasurementUnit = Prod.MassVolumeMeashurementUnit
	/*;END;*/

GO

DECLARE @result VARCHAR(10) = ' /FAIL'
IF(OBJECT_ID( N'view_TreeNSI_Nomenclature') IS NOT NULL)
	SET @result = ' /OK'
print 'CREATE VIEW [dbo].[view_TreeNSI_Nomenclature]' + @result

/************* Блок описания полей *************/
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_Nomenclature', @level2type=N'COLUMN',@level2name=N'IdNomenclature'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Наименование' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_Nomenclature', @level2type=N'COLUMN',@level2name=N'Name'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Полное наименование' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_Nomenclature', @level2type=N'COLUMN',@level2name=N'FullName'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Это группа' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_Nomenclature', @level2type=N'COLUMN',@level2name=N'IsGroup'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Активно' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_Nomenclature', @level2type=N'COLUMN',@level2name=N'IsActive'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Полное наименование родительской группы' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_Nomenclature', @level2type=N'COLUMN',@level2name=N'ParentFulName'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Национальное условное обозначение основной единицы измерения' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_Nomenclature', @level2type=N'COLUMN',@level2name=N'BaseMeasurementUnitDomIdentCode'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код регистрации в каталоге' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_Nomenclature', @level2type=N'COLUMN',@level2name=N'IdCatalog'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код родительской группы' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_Nomenclature', @level2type=N'COLUMN',@level2name=N'ParentId'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Дата начала действия' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_Nomenclature', @level2type=N'COLUMN',@level2name=N'BeginDate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код периодической записи' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_Nomenclature', @level2type=N'COLUMN',@level2name=N'IdProperty'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код основной единицы измерения' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_Nomenclature', @level2type=N'COLUMN',@level2name=N'IdBaseMeasurementUnit'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Номенклатура материальных ценностей, продукции, товаров и услуг' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_Nomenclature'
GO

/************* Конец блока описания полей *************/

IF (EXISTS (SELECT * FROM sys.tables WHERE name = N'view_TreeNSI_Counteragent'))
DROP TABLE [dbo].[view_TreeNSI_Counteragent]

GO

IF(OBJECT_ID( N'view_TreeNSI_Counteragent') IS NOT NULL)
DROP VIEW [dbo].[view_TreeNSI_Counteragent]
GO

--Справочник Контрагенты : юридические лица, организации и предприятия
--МЕТКИ /*; ;*/ НЕ ТРОГАТЬ!!!

CREATE VIEW [dbo].[view_TreeNSI_Counteragent]
AS
/*;START;*/
	WITH prop (IdElement, BeginDate)
		AS
		(
			SELECT IdElement, MAX(BeginDate) FROM TreeNSI_CounteragentProperty
			/*;@;*/
			GROUP BY IdElement
		)
		, grp (id, name)
		AS
		(
		SELECT IdCounteragent, Property.FullName FROM TreeNSI_Counteragent n
		JOIN prop ON prop.IdElement = n.IdCounteragent
		JOIN TreeNSI_CounteragentProperty Property ON Property.IdElement = n.IdCounteragent AND Property.BeginDate = prop.BeginDate
		WHERE IsGroup = 1
		)
	SELECT 
			coun.IdCounteragent,
			coun.Name,
			FullName = ISNULL(Property.FullName,coun.Name),
			CountryName = cry.FullName,
			ParentFulName = grp.name,
			Property.IsActive,
			coun.IdCountry,
			coun.IdCatalog,
			coun.ParentId,
			Property.BeginDate,
			Property.IdProperty

	FROM TreeNSI_Counteragent coun
	JOIN prop ON prop.IdElement = coun.IdCounteragent
	JOIN TreeNSI_CounteragentProperty Property ON Property.IdElement = coun.IdCounteragent AND Property.BeginDate = prop.BeginDate
	JOIN view_TreeNSI_Country cry ON cry.IdCountry = coun.IdCountry
	LEFT JOIN grp ON grp.id = coun.ParentId
/*;END;*/

GO

DECLARE @result VARCHAR(10) = ' /FAIL'
IF(OBJECT_ID( N'view_TreeNSI_Counteragent') IS NOT NULL)
	SET @result = ' /OK'
print 'CREATE VIEW [dbo].[view_TreeNSI_Counteragent]' + @result

/************* Блок описания полей *************/
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_Counteragent', @level2type=N'COLUMN',@level2name=N'IdCounteragent'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Наименование' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_Counteragent', @level2type=N'COLUMN',@level2name=N'Name'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Полное наименование' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_Counteragent', @level2type=N'COLUMN',@level2name=N'FullName'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Страна регистрации' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_Counteragent', @level2type=N'COLUMN',@level2name=N'CountryName'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Полное наименование родительской группы' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_Counteragent', @level2type=N'COLUMN',@level2name=N'ParentFulName'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Активно' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_Counteragent', @level2type=N'COLUMN',@level2name=N'IsActive'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код страны регистрации' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_Counteragent', @level2type=N'COLUMN',@level2name=N'IdCountry'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код регистрации элемента в каталоге' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_Counteragent', @level2type=N'COLUMN',@level2name=N'IdCatalog'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код родительской группы' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_Counteragent', @level2type=N'COLUMN',@level2name=N'ParentId'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Дата начала действия' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_Counteragent', @level2type=N'COLUMN',@level2name=N'BeginDate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код периодической записи' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_Counteragent', @level2type=N'COLUMN',@level2name=N'IdProperty'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Справочник Контрагенты' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_Counteragent'
GO

/************* Конец блока описания полей *************/

IF (EXISTS (SELECT * FROM sys.tables WHERE name = N'view_TreeNSI_Subdivision'))
DROP TABLE [dbo].[view_TreeNSI_Subdivision]

GO

IF(OBJECT_ID( N'view_TreeNSI_Subdivision') IS NOT NULL)
DROP VIEW [dbo].[view_TreeNSI_Subdivision]
GO

--Справочник Структурные подразделения (основные данные, актуальные на текущий момент)
--МЕТКИ /*; ;*/ НЕ ТРОГАТЬ!!!

CREATE VIEW [dbo].[view_TreeNSI_Subdivision]
AS
/*;START;*/
	WITH prop (IdElement, BeginDate)
		AS
		(
			SELECT IdElement, MAX(BeginDate) FROM TreeNSI_SubdivisionProperty
			/*;@;*/
			GROUP BY IdElement
		)
		, grp (id, name)
		AS
		(
		SELECT IdSubdivision, Property.FullName FROM TreeNSI_Subdivision n
		JOIN prop ON prop.IdElement = n.IdSubdivision
		JOIN TreeNSI_SubdivisionProperty Property ON Property.IdElement = n.IdSubdivision AND Property.BeginDate = prop.BeginDate
		WHERE IsGroup = 1
		)
	SELECT 
			sub.IdSubdivision,
			sub.Name,
			Property.FullName,
			sub.IsGroup,
			sub.IsActive,
			ParentFulName = grp.name,

			sub.IdCatalog,
			sub.ParentId,
			Property.BeginDate,
			Property.IdProperty

	FROM TreeNSI_Subdivision sub
	JOIN prop ON prop.IdElement = sub.IdSubdivision
	JOIN TreeNSI_SubdivisionProperty Property ON Property.IdElement = sub.IdSubdivision AND Property.BeginDate = prop.BeginDate
	LEFT JOIN grp ON grp.id = sub.ParentId
	/*;END;*/

GO

DECLARE @result VARCHAR(10) = ' /FAIL'
IF(OBJECT_ID( N'view_TreeNSI_Subdivision') IS NOT NULL)
	SET @result = ' /OK'
print 'CREATE VIEW [dbo].[view_TreeNSI_Subdivision]' + @result

/************* Блок описания полей *************/
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_Subdivision', @level2type=N'COLUMN',@level2name=N'IdSubdivision'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Наименование' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_Subdivision', @level2type=N'COLUMN',@level2name=N'Name'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Полное наименование' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_Subdivision', @level2type=N'COLUMN',@level2name=N'FullName'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Это группа' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_Subdivision', @level2type=N'COLUMN',@level2name=N'IsGroup'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Активно' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_Subdivision', @level2type=N'COLUMN',@level2name=N'IsActive'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Полное наименование родительской группы' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_Subdivision', @level2type=N'COLUMN',@level2name=N'ParentFulName'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код регистрации в каталоге' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_Subdivision', @level2type=N'COLUMN',@level2name=N'IdCatalog'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код родительской группы' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_Subdivision', @level2type=N'COLUMN',@level2name=N'ParentId'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Дата начала действия' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_Subdivision', @level2type=N'COLUMN',@level2name=N'BeginDate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код периодической записи' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_Subdivision', @level2type=N'COLUMN',@level2name=N'IdProperty'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Структурные подразделения Общества' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_Subdivision'
GO

/************* Конец блока описания полей *************/

IF (EXISTS (SELECT * FROM sys.tables WHERE name = N'view_TreeNSI_IndustrialUnit'))
DROP TABLE [dbo].[view_TreeNSI_IndustrialUnit]

GO

IF(OBJECT_ID( N'view_TreeNSI_IndustrialUnit') IS NOT NULL)
DROP VIEW [dbo].[view_TreeNSI_IndustrialUnit]
GO


--Справочник Промышленные утановки, резервуарные парки, склады хранения
--МЕТКИ /*; ;*/ НЕ ТРОГАТЬ!!!

CREATE VIEW [dbo].[view_TreeNSI_IndustrialUnit]
AS
/*;START;*/
	WITH prop (IdElement, BeginDate)
		AS
		(
			SELECT IdElement, MAX(BeginDate) FROM TreeNSI_IndustrialUnitProperty
			/*;@;*/
			GROUP BY IdElement
		)
		, grp (id, name)
		AS
		(
		SELECT IdIndustrialUnit, Property.FullName FROM TreeNSI_IndustrialUnit n
		JOIN prop ON prop.IdElement = n.IdIndustrialUnit
		JOIN TreeNSI_IndustrialUnitProperty Property ON Property.IdElement = n.IdIndustrialUnit AND Property.BeginDate = prop.BeginDate
		WHERE IsGroup = 1
		)
	SELECT 
			sub.IdIndustrialUnit,
			sub.Name,
			Property.FullName,
			sub.IsGroup,
			sub.IsActive,
			ParentFulName = grp.name,

			sub.IdCatalog,
			sub.ParentId,
			Property.BeginDate,
			Property.IdProperty

	FROM TreeNSI_IndustrialUnit sub
	JOIN prop ON prop.IdElement = sub.IdIndustrialUnit
	JOIN TreeNSI_IndustrialUnitProperty Property ON Property.IdElement = sub.IdIndustrialUnit AND Property.BeginDate = prop.BeginDate
	LEFT JOIN grp ON grp.id = sub.ParentId
	/*;END;*/

GO

DECLARE @result VARCHAR(10) = ' /FAIL'
IF(OBJECT_ID( N'view_TreeNSI_IndustrialUnit') IS NOT NULL)
	SET @result = ' /OK'
print 'CREATE VIEW [dbo].[view_TreeNSI_IndustrialUnit]' + @result

/************* Блок описания полей *************/
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_IndustrialUnit', @level2type=N'COLUMN',@level2name=N'IdIndustrialUnit'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Наименование' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_IndustrialUnit', @level2type=N'COLUMN',@level2name=N'Name'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Полное наименование' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_IndustrialUnit', @level2type=N'COLUMN',@level2name=N'FullName'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Это группа' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_IndustrialUnit', @level2type=N'COLUMN',@level2name=N'IsGroup'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Активно' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_IndustrialUnit', @level2type=N'COLUMN',@level2name=N'IsActive'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Полное наименование родительской группы' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_IndustrialUnit', @level2type=N'COLUMN',@level2name=N'ParentFulName'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код регистрации в каталоге' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_IndustrialUnit', @level2type=N'COLUMN',@level2name=N'IdCatalog'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код родительской группы' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_IndustrialUnit', @level2type=N'COLUMN',@level2name=N'ParentId'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Дата начала действия' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_IndustrialUnit', @level2type=N'COLUMN',@level2name=N'BeginDate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код периодической записи' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_IndustrialUnit', @level2type=N'COLUMN',@level2name=N'IdProperty'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Промышленные утановки, резервуарные парки, склады хранения' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_IndustrialUnit'
GO

/************* Конец блока описания полей *************/

IF (EXISTS (SELECT * FROM sys.tables WHERE name = N'view_TreeNSI_IndustrialUnitModule'))
DROP TABLE [dbo].[view_TreeNSI_IndustrialUnitModule]

GO

IF(OBJECT_ID( N'view_TreeNSI_IndustrialUnitModule') IS NOT NULL)
DROP VIEW [dbo].[view_TreeNSI_IndustrialUnitModule]
GO

--Справочник Блок, резервуар, емкость промышленной утановки, резервуарного парка
--МЕТКИ /*; ;*/ НЕ ТРОГАТЬ!!!

CREATE VIEW [dbo].[view_TreeNSI_IndustrialUnitModule]
AS
/*;START;*/
	WITH prop (IdElement, BeginDate)
		AS
		(
			SELECT IdElement, MAX(BeginDate) FROM TreeNSI_IndustrialUnitModuleProperty
			/*;@;*/
			GROUP BY IdElement
		)
		, grp (id, name)
		AS
		(
		SELECT IdIndustrialUnitModule, Property.FullName FROM TreeNSI_IndustrialUnitModule n
		JOIN prop ON prop.IdElement = n.IdIndustrialUnitModule
		JOIN TreeNSI_IndustrialUnitModuleProperty Property ON Property.IdElement = n.IdIndustrialUnitModule AND Property.BeginDate = prop.BeginDate
		WHERE IsGroup = 1
		)
	SELECT 
			sub.IdIndustrialUnitModule,
			sub.Name,
			Property.FullName,
			sub.IsGroup,
			sub.IsActive,
			ParentFulName = grp.name,

			sub.IdCatalog,
			sub.ParentId,
			Property.BeginDate,
			Property.IdProperty

	FROM TreeNSI_IndustrialUnitModule sub
	JOIN prop ON prop.IdElement = sub.IdIndustrialUnitModule
	JOIN TreeNSI_IndustrialUnitModuleProperty Property ON Property.IdElement = sub.IdIndustrialUnitModule AND Property.BeginDate = prop.BeginDate
	LEFT JOIN grp ON grp.id = sub.ParentId
	/*;END;*/

GO

DECLARE @result VARCHAR(10) = ' /FAIL'
IF(OBJECT_ID( N'view_TreeNSI_IndustrialUnitModule') IS NOT NULL)
	SET @result = ' /OK'
print 'CREATE VIEW [dbo].[view_TreeNSI_IndustrialUnitModule]' + @result

/************* Блок описания полей *************/
EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_IndustrialUnitModule', @level2type=N'COLUMN',@level2name=N'IdIndustrialUnitModule'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Наименование' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_IndustrialUnitModule', @level2type=N'COLUMN',@level2name=N'Name'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Полное наименование' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_IndustrialUnitModule', @level2type=N'COLUMN',@level2name=N'FullName'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Это группа' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_IndustrialUnitModule', @level2type=N'COLUMN',@level2name=N'IsGroup'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Активно' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_IndustrialUnitModule', @level2type=N'COLUMN',@level2name=N'IsActive'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Полное наименование родительской группы' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_IndustrialUnitModule', @level2type=N'COLUMN',@level2name=N'ParentFulName'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код регистрации в каталоге' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_IndustrialUnitModule', @level2type=N'COLUMN',@level2name=N'IdCatalog'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код родительской группы' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_IndustrialUnitModule', @level2type=N'COLUMN',@level2name=N'ParentId'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Дата начала действия' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_IndustrialUnitModule', @level2type=N'COLUMN',@level2name=N'BeginDate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код периодической записи' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_IndustrialUnitModule', @level2type=N'COLUMN',@level2name=N'IdProperty'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Блоки, резервуары, емкости утановок' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_TreeNSI_IndustrialUnitModule'
GO

/************* Конец блока описания полей *************/

/********** Конец блока представлений основных регистрируемых справочников ***************/

print 'END FirstStarter ' + + CONVERT(VARCHAR(50) ,GetDATE(), 113 )