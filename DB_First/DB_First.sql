/***************************************************/
/*   СОЗДАНИЕ ОСНОВНЫХ ОБЪЕКТОВ TreeNSI ВРУЧНУЮ    */
/*      ПРИ ИСПОЛЬЗОВАНИИ ПОДХОДА DB-FIRSFT        */
/***************************************************/

USE [TreeNSI]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

print 'TreeNSI_NationalLanguage - Национальные языки'

CREATE TABLE [dbo].[TreeNSI_NationalLanguage](
	[IdLanguage] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](30) NOT NULL,
	[LanguageTag] [varchar](10) NULL,
 CONSTRAINT [PK_TreeNSI_NationalLanguage] PRIMARY KEY CLUSTERED 
(
	[IdLanguage] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_NationalLanguage', @level2type=N'COLUMN',@level2name=N'IdLanguage'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Наименование' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_NationalLanguage', @level2type=N'COLUMN',@level2name=N'Name'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Акроним (формата ru-RU, en-US)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_NationalLanguage', @level2type=N'COLUMN',@level2name=N'LanguageTag'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Национальные языки описания характеристик объектов' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_NationalLanguage'
GO


SET ANSI_PADDING ON
GO
print 'TreeNSI_MeasurementUnit - Единицы измерения и счета'
CREATE TABLE [dbo].[TreeNSI_MeasurementUnit](
	[IdMeasurementUnit] [int] IDENTITY(1,1) NOT NULL,
	[IsGroup] [bit] NOT NULL,
	[ParentId] [int] NULL,
	[Name] [varchar](100) NOT NULL,
	[Description] [nvarchar](200) NULL,
	[InternationalCode] [char](3) NULL,
	[DomesticCode] [char](3) NULL,
	[DomesticIdentificationCode] [nvarchar](30) NOT NULL,
	[InternationalIdentificationCode] [nvarchar](30) NULL,
	[DomesticSymbolCode] [varchar](50) NULL,
	[InternationalSymbolCode] [varchar](10) NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_TreeNSI_MeasurementUnit] PRIMARY KEY CLUSTERED 
(
	[IdMeasurementUnit] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_MeasurementUnit', @level2type=N'COLUMN',@level2name=N'IdMeasurementUnit'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Флаг группы' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_MeasurementUnit', @level2type=N'COLUMN',@level2name=N'IsGroup'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код родителя' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_MeasurementUnit', @level2type=N'COLUMN',@level2name=N'ParentId'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Наименование' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_MeasurementUnit', @level2type=N'COLUMN',@level2name=N'Name'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Описание' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_MeasurementUnit', @level2type=N'COLUMN',@level2name=N'Description'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Международный код' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_MeasurementUnit', @level2type=N'COLUMN',@level2name=N'InternationalCode'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Национальный код' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_MeasurementUnit', @level2type=N'COLUMN',@level2name=N'DomesticCode'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Национальное условное обозначение' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_MeasurementUnit', @level2type=N'COLUMN',@level2name=N'DomesticIdentificationCode'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Международное условное обозначение' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_MeasurementUnit', @level2type=N'COLUMN',@level2name=N'InternationalIdentificationCode'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Национальное кодовое буквенное обозначение' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_MeasurementUnit', @level2type=N'COLUMN',@level2name=N'DomesticSymbolCode'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Международное кодовое буквенное обозначение' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_MeasurementUnit', @level2type=N'COLUMN',@level2name=N'InternationalSymbolCode'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Активно' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_MeasurementUnit', @level2type=N'COLUMN',@level2name=N'IsActive'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Единицы измерения и счета (ОКРБ 008-95)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_MeasurementUnit'
GO


SET ANSI_PADDING ON
GO
print 'TreeNSI_Country - Страны и территории мира'

CREATE TABLE [dbo].[TreeNSI_Country](
	[IdCountry] [int] IDENTITY(1,1) NOT NULL,
	[Code] [char](3) NOT NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_TreeNSI_Country] PRIMARY KEY CLUSTERED 
(
	[IdCountry] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Country', @level2type=N'COLUMN',@level2name=N'IdCountry'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Цифровой код' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Country', @level2type=N'COLUMN',@level2name=N'Code'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Активно' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Country', @level2type=N'COLUMN',@level2name=N'IsActive'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Страны и территории мира (ОКРБ 017-99)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Country'
GO

SET ANSI_PADDING ON
GO
print 'TreeNSI_CountryProperty - Характеристика элемента справочника Страны'

CREATE TABLE [dbo].[TreeNSI_CountryProperty](
	[IdProperty] [int] IDENTITY(1,1) NOT NULL,
	[IdElement] [int] NOT NULL,
	[BeginDate] [date] NOT NULL,
	[Name] [varchar](100) NOT NULL,
	[FullName] [varchar](100) NULL,
	[Alfa2Code] [char](2) NOT NULL,
	[Alfa3Code] [char](3) NOT NULL,
	[IsOffshoreArea] [bit] NOT NULL,
 CONSTRAINT [PK_TreeNSI_CountryProperty] PRIMARY KEY CLUSTERED 
(
	[IdProperty] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_CountryProperty', @level2type=N'COLUMN',@level2name=N'IdProperty'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код владельца' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_CountryProperty', @level2type=N'COLUMN',@level2name=N'IdElement'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Дата начала действия' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_CountryProperty', @level2type=N'COLUMN',@level2name=N'BeginDate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Наименование' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_CountryProperty', @level2type=N'COLUMN',@level2name=N'Name'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Полное наименование' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_CountryProperty', @level2type=N'COLUMN',@level2name=N'FullName'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Буквенный код альфа-2' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_CountryProperty', @level2type=N'COLUMN',@level2name=N'Alfa2Code'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Буквенный код альфа-3' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_CountryProperty', @level2type=N'COLUMN',@level2name=N'Alfa3Code'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Это офшорная зона' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_CountryProperty', @level2type=N'COLUMN',@level2name=N'IsOffshoreArea'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Характеристика элемента справочника Страны' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_CountryProperty'
GO

SET ANSI_PADDING ON
GO
print 'TreeNSI_CountryNationalData - Наименование стран мира на различных языках'
CREATE TABLE [dbo].[TreeNSI_CountryNationalData](
	[IdCountryNationalData] [int] IDENTITY(1,1) NOT NULL,
	[IdCountry] [int] NOT NULL,
	[IdLanguage] [int] NOT NULL,
	[FullName] [nvarchar](100) NOT NULL,
	[BeginDate] [date] NOT NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_TreeNSI_CountryNationalData] PRIMARY KEY CLUSTERED 
(
	[IdCountryNationalData] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_CountryNationalData', @level2type=N'COLUMN',@level2name=N'IdCountryNationalData'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код страны' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_CountryNationalData', @level2type=N'COLUMN',@level2name=N'IdCountry'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код национального языка' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_CountryNationalData', @level2type=N'COLUMN',@level2name=N'IdLanguage'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Полное наименование на национальном языке' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_CountryNationalData', @level2type=N'COLUMN',@level2name=N'FullName'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Дата начала действия' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_CountryNationalData', @level2type=N'COLUMN',@level2name=N'BeginDate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Активно' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_CountryNationalData', @level2type=N'COLUMN',@level2name=N'IsActive'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Наименование стран мира на различных языках' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_CountryNationalData'
GO

SET ANSI_PADDING ON
GO
print 'TreeNSI_CountryUnion - Геополитические объединения стран'
CREATE TABLE [dbo].[TreeNSI_CountryUnion](
	[IdCountryUnion] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[FullName] [varchar](200) NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_TreeNSI_CountryUnion] PRIMARY KEY CLUSTERED 
(
	[IdCountryUnion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_CountryUnion', @level2type=N'COLUMN',@level2name=N'IdCountryUnion'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Наименование' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_CountryUnion', @level2type=N'COLUMN',@level2name=N'Name'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Полное наименование' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_CountryUnion', @level2type=N'COLUMN',@level2name=N'FullName'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Актуально' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_CountryUnion', @level2type=N'COLUMN',@level2name=N'IsActive'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Геополитические объединения стран' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_CountryUnion'
GO

SET ANSI_PADDING ON
GO
print 'TreeNSI_CountryUnionMember - Состав геополитических объединений стран'
CREATE TABLE [dbo].[TreeNSI_CountryUnionMember](
	[IdCountryUnionMember] [int] IDENTITY(1,1) NOT NULL,
	[IdCountryUnion] [int] NOT NULL,
	[IdCountry] [int] NOT NULL,
	[BeginDate] [date] NULL,
	[EndDate] [date] NULL,
 CONSTRAINT [PK_TreeNSI_CountryUnionMember] PRIMARY KEY CLUSTERED 
(
	[IdCountryUnionMember] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO


EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код записи' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_CountryUnionMember', @level2type=N'COLUMN',@level2name=N'IdCountryUnionMember'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код объединения' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_CountryUnionMember', @level2type=N'COLUMN',@level2name=N'IdCountryUnion'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код страны, соответствует dbf_str.kstr' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_CountryUnionMember', @level2type=N'COLUMN',@level2name=N'IdCountry'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Дата начала участия' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_CountryUnionMember', @level2type=N'COLUMN',@level2name=N'BeginDate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Дата завершения участия' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_CountryUnionMember', @level2type=N'COLUMN',@level2name=N'EndDate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Состав геополитических объединений стран' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_CountryUnionMember'
GO

SET ANSI_PADDING ON
GO
print 'TreeNSI_Currency - Валюты'
CREATE TABLE [dbo].[TreeNSI_Currency](
	[IdCurrency] [int] IDENTITY(1,1) NOT NULL,
	[Code] [char](3) NOT NULL,
	[AlfaCode] [char](3) NOT NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_TreeNSI_Currency] PRIMARY KEY CLUSTERED 
(
	[IdCurrency] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Currency', @level2type=N'COLUMN',@level2name=N'IdCurrency'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Цифровой код' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Currency', @level2type=N'COLUMN',@level2name=N'Code'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Буквенный код' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Currency', @level2type=N'COLUMN',@level2name=N'AlfaCode'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Активно' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Currency', @level2type=N'COLUMN',@level2name=N'IsActive'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Валюты (ОКРБ 016-99)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Currency'
GO

SET ANSI_PADDING ON
GO
print 'TreeNSI_CurrencyProperty - Характеристика валюты'
CREATE TABLE [dbo].[TreeNSI_CurrencyProperty](
	[IdProperty] [int] IDENTITY(1,1) NOT NULL,
	[IdElement] [int] NOT NULL,
	[BeginDate] [date] NOT NULL,
	[Name] [varchar](100) NOT NULL,
 CONSTRAINT [PK_TreeNSI_CurrencyProperty] PRIMARY KEY CLUSTERED 
(
	[IdProperty] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_CurrencyProperty', @level2type=N'COLUMN',@level2name=N'IdProperty'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код владельца' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_CurrencyProperty', @level2type=N'COLUMN',@level2name=N'IdElement'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Дата начала действия' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_CurrencyProperty', @level2type=N'COLUMN',@level2name=N'BeginDate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Наименование' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_CurrencyProperty', @level2type=N'COLUMN',@level2name=N'Name'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Характеристика валюты' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_CurrencyProperty'
GO
/********************************************************************************************************************************************/
SET ANSI_PADDING ON
GO
print 'TreeNSI_RailwayCountry - Страны участницы ОСЖД'
CREATE TABLE [dbo].[TreeNSI_RailwayCountry](
	[IdRailwayCountry] [int] IDENTITY(1,1) NOT NULL,
	[ContinentCode] [int] NOT NULL,
	[Code] [char](2) NOT NULL,
	[IdCountry] [int] NOT NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_TreeNSI_RailwayCountry] PRIMARY KEY CLUSTERED 
(
	[IdRailwayCountry] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Идентификатор' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_RailwayCountry', @level2type=N'COLUMN',@level2name=N'IdRailwayCountry'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код континента' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_RailwayCountry', @level2type=N'COLUMN',@level2name=N'ContinentCode'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Железнодорожный код страны' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_RailwayCountry', @level2type=N'COLUMN',@level2name=N'Code'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код страны' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_RailwayCountry', @level2type=N'COLUMN',@level2name=N'IdCountry'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Активно' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_RailwayCountry', @level2type=N'COLUMN',@level2name=N'IsActive'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Страны участницы ОСЖД' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_RailwayCountry'
GO

SET ANSI_PADDING ON
GO
print 'TreeNSI_RailwayCountryProperty - Описание страны участницы ОСЖД'
CREATE TABLE [dbo].[TreeNSI_RailwayCountryProperty](
	[IdProperty] [int] IDENTITY(1,1) NOT NULL,
	[IdElement] [int] NOT NULL,
	[BeginDate] [date] NOT NULL,
	[RICS] [char](4) NULL,
	[RailwayShortName] [varchar](20) NOT NULL,
	[RailwayFullName] [varchar](100) NULL,
	[RailwayShortNameTranslit] [nvarchar](20) NULL,
 CONSTRAINT [PK_TreeNSI_RailwayCountryProperty] PRIMARY KEY CLUSTERED 
(
	[IdProperty] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_RailwayCountryProperty', @level2type=N'COLUMN',@level2name=N'IdProperty'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код владельца' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_RailwayCountryProperty', @level2type=N'COLUMN',@level2name=N'IdElement'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Дата начала действия' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_RailwayCountryProperty', @level2type=N'COLUMN',@level2name=N'BeginDate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код железнодорожного предприятия' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_RailwayCountryProperty', @level2type=N'COLUMN',@level2name=N'RICS'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Сокращенное наименование железной дороги на русском языке' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_RailwayCountryProperty', @level2type=N'COLUMN',@level2name=N'RailwayShortName'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Полное наименование железной дороги на русском языке' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_RailwayCountryProperty', @level2type=N'COLUMN',@level2name=N'RailwayFullName'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Сокращенное наименование железной дороги на латыни' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_RailwayCountryProperty', @level2type=N'COLUMN',@level2name=N'RailwayShortNameTranslit'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Описание страны участницы ОСЖД' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_RailwayCountryProperty'
GO

SET ANSI_PADDING ON
GO
print 'TreeNSI_RailwayCompany - Железнодорожные предприятия'
CREATE TABLE [dbo].[TreeNSI_RailwayCompany](
	[IdRailwayCompany] [int] IDENTITY(1,1) NOT NULL,
	[IdCountry] [int] NOT NULL,
	[CodeRICS] [varchar](4) NULL,
	[ShortName] [nvarchar](50) NULL,
	[FullName] [nvarchar](250) NULL,
	[IsRWAdministation] [bit] NOT NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_TreeNSI_RailwayCompany] PRIMARY KEY CLUSTERED 
(
	[IdRailwayCompany] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Индентификатор записи' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_RailwayCompany', @level2type=N'COLUMN',@level2name=N'IdRailwayCompany'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Страна' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_RailwayCompany', @level2type=N'COLUMN',@level2name=N'IdCountry'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код RICS' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_RailwayCompany', @level2type=N'COLUMN',@level2name=N'CodeRICS'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Сокращенное наименование' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_RailwayCompany', @level2type=N'COLUMN',@level2name=N'ShortName'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Полное наименование' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_RailwayCompany', @level2type=N'COLUMN',@level2name=N'FullName'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'ЖД администрация' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_RailwayCompany', @level2type=N'COLUMN',@level2name=N'IsRWAdministation'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Активно' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_RailwayCompany', @level2type=N'COLUMN',@level2name=N'IsActive'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Железнодорожные предприятия' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_RailwayCompany'
GO

SET ANSI_PADDING ON
GO
print 'TreeNSI_RailwayCompanyTranslitName - Железнодорожные предприятия (транслитерация)'
CREATE TABLE [dbo].[TreeNSI_RailwayCompanyTranslitName](
	[IdRailwayCompany] [int] NOT NULL,
	[ShortName] [nvarchar](50) NULL,
	[FullName] [nvarchar](250) NULL,
 CONSTRAINT [PK_TreeNSI_RailwayCompanyTranslitName] PRIMARY KEY CLUSTERED 
(
	[IdRailwayCompany] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Индентификатор предприятия' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_RailwayCompanyTranslitName', @level2type=N'COLUMN',@level2name=N'IdRailwayCompany'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Сокращенное наименование' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_RailwayCompanyTranslitName', @level2type=N'COLUMN',@level2name=N'ShortName'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Полное наименование' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_RailwayCompanyTranslitName', @level2type=N'COLUMN',@level2name=N'FullName'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Железнодорожные предприятия (транслитерация)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_RailwayCompanyTranslitName'
GO

SET ANSI_PADDING ON
GO
print 'TreeNSI_RailwayAdministration - Управляющие инфраструктурой ЖД предприятия'
CREATE TABLE [dbo].[TreeNSI_RailwayAdministration](
	[IdRailwayCompany] [int] NOT NULL,
	[ShortName] [nvarchar](50) NULL,
	[FullName] [nvarchar](250) NULL,
 CONSTRAINT [PK_TreeNSI_RailwayAdministration] PRIMARY KEY CLUSTERED 
(
	[IdRailwayCompany] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Индентификатор предприятия' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_RailwayAdministration', @level2type=N'COLUMN',@level2name=N'IdRailwayCompany'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Сокращенное наименование' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_RailwayAdministration', @level2type=N'COLUMN',@level2name=N'ShortName'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Полное наименование' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_RailwayAdministration', @level2type=N'COLUMN',@level2name=N'FullName'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Управляющие инфраструктурой ЖД предприятия' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_RailwayAdministration'
GO

SET ANSI_PADDING ON
GO
print 'TreeNSI_RailwayStantion - Грузовые железнодорожные станции'
CREATE TABLE [dbo].[TreeNSI_RailwayStantion](
	[IdRailwayStantion] [int] IDENTITY(1,1) NOT NULL,
	[IdRailwayCountry] [int] NOT NULL,
	[Code] [char](6) NULL,
	[Name] [nvarchar](100) NOT NULL,
	[BorderPointCode] [varchar](4) NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_TreeNSI_RailwayStantion] PRIMARY KEY CLUSTERED 
(
	[IdRailwayStantion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Идентификатор' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_RailwayStantion', @level2type=N'COLUMN',@level2name=N'IdRailwayStantion'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Идентификатор страны ЖД' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_RailwayStantion', @level2type=N'COLUMN',@level2name=N'IdRailwayCountry'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код станции' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_RailwayStantion', @level2type=N'COLUMN',@level2name=N'Code'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Наименование' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_RailwayStantion', @level2type=N'COLUMN',@level2name=N'Name'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код пограничного перехода' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_RailwayStantion', @level2type=N'COLUMN',@level2name=N'BorderPointCode'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Активно' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_RailwayStantion', @level2type=N'COLUMN',@level2name=N'IsActive'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Грузовые железнодорожные станции' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_RailwayStantion'
GO

SET ANSI_PADDING ON
GO
print 'TreeNSI_RailwayStantionNationalData - Название ЖД станций на различных языках'
CREATE TABLE [dbo].[TreeNSI_RailwayStantionNationalData](
	[IdStantionNationalData] [int] IDENTITY(1,1) NOT NULL,
	[IdRailwayStantion] [int] NOT NULL,
	[IdLanguage] [int] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_TreeNSI_RailwayStantionNationalData] PRIMARY KEY CLUSTERED 
(
	[IdStantionNationalData] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_RailwayStantionNationalData', @level2type=N'COLUMN',@level2name=N'IdStantionNationalData'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Идентификатор страны' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_RailwayStantionNationalData', @level2type=N'COLUMN',@level2name=N'IdRailwayStantion'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код национального языка' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_RailwayStantionNationalData', @level2type=N'COLUMN',@level2name=N'IdLanguage'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Название на национальном языке' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_RailwayStantionNationalData', @level2type=N'COLUMN',@level2name=N'Name'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Активно' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_RailwayStantionNationalData', @level2type=N'COLUMN',@level2name=N'IsActive'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Название ЖД станций на различных языках' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_RailwayStantionNationalData'
GO

SET ANSI_PADDING ON
GO
print 'TreeNSI_RailwayStantionTranslit - ЖД станции, транслитерация названий'
CREATE TABLE [dbo].[TreeNSI_RailwayStantionTranslit](
	[IdRailwayStantion] [int] NOT NULL,
	[NameTranslit] [nvarchar](100) NULL,
 CONSTRAINT [PK_TreeNSI_RailwayStantionTranslit] PRIMARY KEY CLUSTERED 
(
	[IdRailwayStantion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Идентификатор станции' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_RailwayStantionTranslit', @level2type=N'COLUMN',@level2name=N'IdRailwayStantion'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Название станции на латыни (транслитерация)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_RailwayStantionTranslit', @level2type=N'COLUMN',@level2name=N'NameTranslit'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'ЖД станции, транслитерация названий' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_RailwayStantionTranslit'
GO

SET ANSI_PADDING ON
GO
print 'TreeNSI_RailwayBorderPoint - Пограничные и переходные пункты'
CREATE TABLE [dbo].[TreeNSI_RailwayBorderPoint](
	[IdRailwayBorderPoint] [int] IDENTITY(1,1) NOT NULL,
	[Code] [char](4) NULL,
	[BorderPointType] [int] NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_TreeNSI_RailwayBorderPoint] PRIMARY KEY CLUSTERED 
(
	[IdRailwayBorderPoint] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Идентификатор' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_RailwayBorderPoint', @level2type=N'COLUMN',@level2name=N'IdRailwayBorderPoint'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код перехода' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_RailwayBorderPoint', @level2type=N'COLUMN',@level2name=N'Code'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Тип перехода (2-жд,3-порт,4-паром)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_RailwayBorderPoint', @level2type=N'COLUMN',@level2name=N'BorderPointType'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Активно' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_RailwayBorderPoint', @level2type=N'COLUMN',@level2name=N'IsActive'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Пограничные и переходные пункты ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_RailwayBorderPoint'
GO

SET ANSI_PADDING ON
GO
print 'TreeNSI_RailwayBorderPointMembers - Станции пограничных и переходных пунктов'
CREATE TABLE [dbo].[TreeNSI_RailwayBorderPointMembers](
	[IdRailwayBorderPoint] [int] NOT NULL,
	[IdRailwayStantion] [int] NOT NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_TreeNSI_RailwayBorderPointMembers] PRIMARY KEY CLUSTERED 
(
	[IdRailwayBorderPoint] ASC,
	[IdRailwayStantion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Идентификатор' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_RailwayBorderPointMembers', @level2type=N'COLUMN',@level2name=N'IdRailwayBorderPoint'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'ЖД станция' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_RailwayBorderPointMembers', @level2type=N'COLUMN',@level2name=N'IdRailwayStantion'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Активно' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_RailwayBorderPointMembers', @level2type=N'COLUMN',@level2name=N'IsActive'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Станции пограничных и переходных пунктов' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_RailwayBorderPointMembers'
GO

SET ANSI_PADDING ON
GO
print 'TreeNSI_RailwayDangerousGoodsRegulation - Правила перевозки опасных грузов железнодорожным транспортом (Соглашение о международном железнодорожном сообщении СМГС)'
CREATE TABLE [dbo].[TreeNSI_RailwayDangerousGoodsRegulation](
	[IdRailwayDG] [int] IDENTITY(1,1) NOT NULL,
	[UNCode] [char](4) NOT NULL,
	[Name] [varchar](600) NOT NULL,
	[Class] [varchar](10) NULL,
	[ClassificationCode] [varchar](15) NULL,
	[PackingGroup] [varchar](3) NULL,
	[DangerSing] [varchar](15) NULL,
	[SpecialProvision] [varchar](30) NULL,
	[LimitedQuantity] [varchar](20) NULL,
	[ExceptedQuantity] [char](2) NULL,
	[PackingInstruction] [varchar](25) NULL,
	[PackingSpecialProvision] [varchar](30) NULL,
	[CommonPackingProvision] [varchar](15) NULL,
	[PortableTankInstruction] [varchar](15) NULL,
	[PortableTankSpecialProvision] [varchar](20) NULL,
	[TankWagonCode] [varchar](30) NULL,
	[TankWagonSpecialProvision] [varchar](60) NULL,
	[TransportCategory] [int] NULL,
	[CargoItemSpecialProvision] [varchar](10) NULL,
	[BulkCarriageSpecialProvision] [varchar](10) NULL,
	[CargoOperationsSpecialProvision] [varchar](50) NULL,
	[HazarCode] [varchar](5) NULL,
	[EmergencyCardNumber] [char](3) NULL,
	[MinimalCoverRate] [varchar](30) NULL,
	[HumpYardCondition] [varchar](10) NULL,
	[Description] [varchar](100) NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_TreeNSI_RailwayDangerousGoodsRegulation] PRIMARY KEY CLUSTERED 
(
	[IdRailwayDG] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_RailwayDangerousGoodsRegulation', @level2type=N'COLUMN',@level2name=N'IdRailwayDG'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код опасности ООН' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_RailwayDangerousGoodsRegulation', @level2type=N'COLUMN',@level2name=N'UNCode'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Наименование вещества' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_RailwayDangerousGoodsRegulation', @level2type=N'COLUMN',@level2name=N'Name'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Класс опасности' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_RailwayDangerousGoodsRegulation', @level2type=N'COLUMN',@level2name=N'Class'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Классификационный код' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_RailwayDangerousGoodsRegulation', @level2type=N'COLUMN',@level2name=N'ClassificationCode'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Группа упаковки' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_RailwayDangerousGoodsRegulation', @level2type=N'COLUMN',@level2name=N'PackingGroup'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Знак опасности' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_RailwayDangerousGoodsRegulation', @level2type=N'COLUMN',@level2name=N'DangerSing'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Специальные положения' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_RailwayDangerousGoodsRegulation', @level2type=N'COLUMN',@level2name=N'SpecialProvision'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Ограниченные количества' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_RailwayDangerousGoodsRegulation', @level2type=N'COLUMN',@level2name=N'LimitedQuantity'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Освобожденные количества' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_RailwayDangerousGoodsRegulation', @level2type=N'COLUMN',@level2name=N'ExceptedQuantity'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Инструкции по упаковке' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_RailwayDangerousGoodsRegulation', @level2type=N'COLUMN',@level2name=N'PackingInstruction'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Специальные положения по упаковке' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_RailwayDangerousGoodsRegulation', @level2type=N'COLUMN',@level2name=N'PackingSpecialProvision'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Положения по совместной упаковке' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_RailwayDangerousGoodsRegulation', @level2type=N'COLUMN',@level2name=N'CommonPackingProvision'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Инструкция по переносной цистерне (контейнера для груза навалом)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_RailwayDangerousGoodsRegulation', @level2type=N'COLUMN',@level2name=N'PortableTankInstruction'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Специальные положения по переносной цистерне (контейнера для груза навалом)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_RailwayDangerousGoodsRegulation', @level2type=N'COLUMN',@level2name=N'PortableTankSpecialProvision'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код цистерны' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_RailwayDangerousGoodsRegulation', @level2type=N'COLUMN',@level2name=N'TankWagonCode'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Специальные положения по цистерне' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_RailwayDangerousGoodsRegulation', @level2type=N'COLUMN',@level2name=N'TankWagonSpecialProvision'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Транспортная категория' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_RailwayDangerousGoodsRegulation', @level2type=N'COLUMN',@level2name=N'TransportCategory'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Специальные положения по перевозке грузовых мест' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_RailwayDangerousGoodsRegulation', @level2type=N'COLUMN',@level2name=N'CargoItemSpecialProvision'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Специальные положения по перевозке навалом' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_RailwayDangerousGoodsRegulation', @level2type=N'COLUMN',@level2name=N'BulkCarriageSpecialProvision'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Специальные положения по погрузке-разгрузке' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_RailwayDangerousGoodsRegulation', @level2type=N'COLUMN',@level2name=N'CargoOperationsSpecialProvision'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код опасности' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_RailwayDangerousGoodsRegulation', @level2type=N'COLUMN',@level2name=N'HazarCode'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Номер аварийной карточки' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_RailwayDangerousGoodsRegulation', @level2type=N'COLUMN',@level2name=N'EmergencyCardNumber'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Минимальные нормы прикрытия' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_RailwayDangerousGoodsRegulation', @level2type=N'COLUMN',@level2name=N'MinimalCoverRate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Условия пропуска с сортировочной горки' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_RailwayDangerousGoodsRegulation', @level2type=N'COLUMN',@level2name=N'HumpYardCondition'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Пояснение' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_RailwayDangerousGoodsRegulation', @level2type=N'COLUMN',@level2name=N'Description'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Активно' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_RailwayDangerousGoodsRegulation', @level2type=N'COLUMN',@level2name=N'IsActive'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Правила перевозки опасных грузов железнодорожным транспортом (Соглашение о международном железнодорожном сообщении СМГС)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_RailwayDangerousGoodsRegulation'
GO
/********************************************************************************************************************************************************************************/
SET ANSI_PADDING ON
GO
print 'TreeNSI_RBRailwayDangerousGoodsRegulation - Правила по обеспечению безопасности перевозки опасных грузов железнодорожным транспортом по территории Республики Беларусь (МЧС 28.12.2012 №73)'
CREATE TABLE [dbo].[TreeNSI_RBRailwayDangerousGoodsRegulation](
	[IdRBRailwayDG] [int] IDENTITY(1,1) NOT NULL,
	[UNCode] [char](4) NOT NULL,
	[Name] [varchar](400) NOT NULL,
	[Description] [varchar](400) NULL,
	[EmergencyCardNumber] [char](3) NULL,
	[ClassificationCode] [varchar](20) NULL,
	[HazarClass] [varchar](10) NULL,
	[HazarCategoryNumber] [int] NULL,
	[BasicDangerSingNumber] [varchar](15) NULL,
	[AdditionalDangerSingNumber] [varchar](15) NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_TreeNSI_RBRailwayDangerousGoodsRegulation] PRIMARY KEY CLUSTERED 
(
	[IdRBRailwayDG] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_RBRailwayDangerousGoodsRegulation', @level2type=N'COLUMN',@level2name=N'IdRBRailwayDG'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код опасности ООН' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_RBRailwayDangerousGoodsRegulation', @level2type=N'COLUMN',@level2name=N'UNCode'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Наименование вещества' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_RBRailwayDangerousGoodsRegulation', @level2type=N'COLUMN',@level2name=N'Name'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Пояснение' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_RBRailwayDangerousGoodsRegulation', @level2type=N'COLUMN',@level2name=N'Description'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Номер аварийной карточки' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_RBRailwayDangerousGoodsRegulation', @level2type=N'COLUMN',@level2name=N'EmergencyCardNumber'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Классификационный код' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_RBRailwayDangerousGoodsRegulation', @level2type=N'COLUMN',@level2name=N'ClassificationCode'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Класс опасности' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_RBRailwayDangerousGoodsRegulation', @level2type=N'COLUMN',@level2name=N'HazarClass'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Номер категории опасности' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_RBRailwayDangerousGoodsRegulation', @level2type=N'COLUMN',@level2name=N'HazarCategoryNumber'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Номер основного знака опасности' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_RBRailwayDangerousGoodsRegulation', @level2type=N'COLUMN',@level2name=N'BasicDangerSingNumber'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Номер дополнительного знака опасности' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_RBRailwayDangerousGoodsRegulation', @level2type=N'COLUMN',@level2name=N'AdditionalDangerSingNumber'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Активно' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_RBRailwayDangerousGoodsRegulation', @level2type=N'COLUMN',@level2name=N'IsActive'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Правила по обеспечению безопасности перевозки опасных грузов железнодорожным транспортом по территории Республики Беларусь (МЧС 28.12.2012 №73)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_RBRailwayDangerousGoodsRegulation'
GO

SET ANSI_PADDING ON
GO
print 'TreeNSI_RoadDangerousGoodsRegulation - Правила по обеспечению безопасности перевозки опасных грузов автомобильным транспортом в Республике Беларусь (Пост. МЧС от 08.12.2010 N 61)'
CREATE TABLE [dbo].[TreeNSI_RoadDangerousGoodsRegulation](
	[IdRoadDG] [int] IDENTITY(1,1) NOT NULL,
	[UNCode] [char](4) NOT NULL,
	[Name] [varchar](500) NOT NULL,
	[Class] [varchar](10) NULL,
	[ClassificationCode] [varchar](15) NULL,
	[PackingGroup] [varchar](3) NULL,
	[DangerSing] [varchar](15) NULL,
	[SpecialProvision] [varchar](20) NULL,
	[Restriction] [varchar](15) NULL,
	[PackingInstruction] [varchar](25) NULL,
	[PackingSpecialProvision] [varchar](30) NULL,
	[CommonPackingProvision] [varchar](15) NULL,
	[TankerTransport] [char](2) NULL,
	[TransportCategory] [int] NULL,
	[HazarIdentificationNumber] [varchar](4) NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_TreeNSI_RoadDangerousGoodsRegulation] PRIMARY KEY CLUSTERED 
(
	[IdRoadDG] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_RoadDangerousGoodsRegulation', @level2type=N'COLUMN',@level2name=N'IdRoadDG'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код опасности ООН' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_RoadDangerousGoodsRegulation', @level2type=N'COLUMN',@level2name=N'UNCode'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Наименование и пояснение' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_RoadDangerousGoodsRegulation', @level2type=N'COLUMN',@level2name=N'Name'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Класс опасности' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_RoadDangerousGoodsRegulation', @level2type=N'COLUMN',@level2name=N'Class'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Классификационный код' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_RoadDangerousGoodsRegulation', @level2type=N'COLUMN',@level2name=N'ClassificationCode'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Группа упаковки' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_RoadDangerousGoodsRegulation', @level2type=N'COLUMN',@level2name=N'PackingGroup'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Знак опасности' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_RoadDangerousGoodsRegulation', @level2type=N'COLUMN',@level2name=N'DangerSing'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Специальные положения' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_RoadDangerousGoodsRegulation', @level2type=N'COLUMN',@level2name=N'SpecialProvision'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Ограниченные и освобожденные количества' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_RoadDangerousGoodsRegulation', @level2type=N'COLUMN',@level2name=N'Restriction'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Инструкции по упаковке' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_RoadDangerousGoodsRegulation', @level2type=N'COLUMN',@level2name=N'PackingInstruction'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Специальные положения по упаковке' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_RoadDangerousGoodsRegulation', @level2type=N'COLUMN',@level2name=N'PackingSpecialProvision'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Положения по совместной упаковке' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_RoadDangerousGoodsRegulation', @level2type=N'COLUMN',@level2name=N'CommonPackingProvision'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Транспортное средство для перевозки в цистернах' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_RoadDangerousGoodsRegulation', @level2type=N'COLUMN',@level2name=N'TankerTransport'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Транспортная категория' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_RoadDangerousGoodsRegulation', @level2type=N'COLUMN',@level2name=N'TransportCategory'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Идентификационный номер опасности' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_RoadDangerousGoodsRegulation', @level2type=N'COLUMN',@level2name=N'HazarIdentificationNumber'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Активно' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_RoadDangerousGoodsRegulation', @level2type=N'COLUMN',@level2name=N'IsActive'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Правила по обеспечению безопасности перевозки опасных грузов автомобильным транспортом в Республике Беларусь (Пост. МЧС от 08.12.2010 N 61)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_RoadDangerousGoodsRegulation'
GO
/*********************************************************************************************************************************************************************************************/
SET ANSI_PADDING ON
GO
print 'TreeNSI_EAEUCommonCustomsTariff - Единый таможенный тариф Евразийского экономического союза'
CREATE TABLE [dbo].[TreeNSI_EAEUCommonCustomsTariff](
	[IdCommonCustomsTariff] [int] IDENTITY(1,1) NOT NULL,
	[IsGroup] [bit] NOT NULL,
	[ParentId] [int] NULL,
	[Code] [varchar](15) NULL,
	[Name] [varchar](1000) NOT NULL,
	[AdditionalMeasurementUnit] [varchar](20) NULL,
	[DutyRate] [varchar](70) NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_TreeNSI_EAEUCommonCustomsTariff] PRIMARY KEY CLUSTERED 
(
	[IdCommonCustomsTariff] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_EAEUCommonCustomsTariff', @level2type=N'COLUMN',@level2name=N'IdCommonCustomsTariff'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Флаг группы' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_EAEUCommonCustomsTariff', @level2type=N'COLUMN',@level2name=N'IsGroup'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код родителя' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_EAEUCommonCustomsTariff', @level2type=N'COLUMN',@level2name=N'ParentId'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код ТН ВЭД' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_EAEUCommonCustomsTariff', @level2type=N'COLUMN',@level2name=N'Code'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Наименование' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_EAEUCommonCustomsTariff', @level2type=N'COLUMN',@level2name=N'Name'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Доп. ед. изм.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_EAEUCommonCustomsTariff', @level2type=N'COLUMN',@level2name=N'AdditionalMeasurementUnit'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Ставка ввозной таможенной пошлины' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_EAEUCommonCustomsTariff', @level2type=N'COLUMN',@level2name=N'DutyRate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Активно' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_EAEUCommonCustomsTariff', @level2type=N'COLUMN',@level2name=N'IsActive'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Единый таможенный тариф Евразийского экономического союза' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_EAEUCommonCustomsTariff'
GO

SET ANSI_PADDING ON
GO
print 'TreeNSI_EconomicActivityProductsClassificationType - Укрупненная структура классификатора продукции по видам экономической деятельности ОКРБ 007-2012'
CREATE TABLE [dbo].[TreeNSI_EconomicActivityProductsClassificationType](
	[IdClassType] [int] IDENTITY(1,1) NOT NULL,
	[IsGroup] [bit] NOT NULL,
	[ParentId] [int] NULL,
	[Code] [varchar](2) NULL,
	[Name] [varchar](200) NOT NULL,
 CONSTRAINT [PK_TreeNSI_EconomicActivityProductsClassificationType] PRIMARY KEY CLUSTERED 
(
	[IdClassType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_EconomicActivityProductsClassificationType', @level2type=N'COLUMN',@level2name=N'IdClassType'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Флаг группы' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_EconomicActivityProductsClassificationType', @level2type=N'COLUMN',@level2name=N'IsGroup'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код родителя' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_EconomicActivityProductsClassificationType', @level2type=N'COLUMN',@level2name=N'ParentId'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код по классификатору ОКРБ 2007' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_EconomicActivityProductsClassificationType', @level2type=N'COLUMN',@level2name=N'Code'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Наименование' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_EconomicActivityProductsClassificationType', @level2type=N'COLUMN',@level2name=N'Name'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Укрупненная структура классификатора продукции по видам экономической деятельности ОКРБ 007-2012' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_EconomicActivityProductsClassificationType'
GO

SET ANSI_PADDING ON
GO
print 'TreeNSI_EconomicActivityProductsClassification - Классификатор продукции по видам экономической деятельности ОКРБ 007-2012'
CREATE TABLE [dbo].[TreeNSI_EconomicActivityProductsClassification](
	[IdClassProduct] [int] IDENTITY(1,1) NOT NULL,
	[IdClassType] [int] NOT NULL,
	[IsGroup] [bit] NOT NULL,
	[ParentId] [int] NULL,
	[Code] [varchar](12) NULL,
	[Name] [varchar](550) NOT NULL,
 CONSTRAINT [PK_TreeNSI_TreeNSI_EconomicActivityProductsClassification] PRIMARY KEY CLUSTERED 
(
	[IdClassProduct] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_EconomicActivityProductsClassification', @level2type=N'COLUMN',@level2name=N'IdClassProduct'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Секция (подсекция) классификатора' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_EconomicActivityProductsClassification', @level2type=N'COLUMN',@level2name=N'IdClassType'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Флаг группы' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_EconomicActivityProductsClassification', @level2type=N'COLUMN',@level2name=N'IsGroup'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код родителя' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_EconomicActivityProductsClassification', @level2type=N'COLUMN',@level2name=N'ParentId'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код по классификатору ОКРБ 2007' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_EconomicActivityProductsClassification', @level2type=N'COLUMN',@level2name=N'Code'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Наименование' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_EconomicActivityProductsClassification', @level2type=N'COLUMN',@level2name=N'Name'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Классификатор продукции по видам экономической деятельности ОКРБ 007-2012' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_EconomicActivityProductsClassification'
GO

SET ANSI_PADDING ON
GO
print 'TreeNSI_CargoesHarmonizedNomenclature - Гармонизированная номенклатура грузов (ГНГ)'
CREATE TABLE [dbo].[TreeNSI_CargoesHarmonizedNomenclature](
	[IdCargoesHarmonizedNomenclature] [int] IDENTITY(1,1) NOT NULL,
	[IsGroup] [bit] NOT NULL,
	[ParentId] [int] NULL,
	[Code] [varchar](8) NULL,
	[Name] [varchar](850) NOT NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_TreeNSI_CargoesHarmonizedNomenclature] PRIMARY KEY CLUSTERED 
(
	[IdCargoesHarmonizedNomenclature] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_CargoesHarmonizedNomenclature', @level2type=N'COLUMN',@level2name=N'IdCargoesHarmonizedNomenclature'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Флаг группы' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_CargoesHarmonizedNomenclature', @level2type=N'COLUMN',@level2name=N'IsGroup'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код родителя' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_CargoesHarmonizedNomenclature', @level2type=N'COLUMN',@level2name=N'ParentId'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код ГНГ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_CargoesHarmonizedNomenclature', @level2type=N'COLUMN',@level2name=N'Code'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Наименование' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_CargoesHarmonizedNomenclature', @level2type=N'COLUMN',@level2name=N'Name'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Активно' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_CargoesHarmonizedNomenclature', @level2type=N'COLUMN',@level2name=N'IsActive'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Гармонизированная номенклатура грузов (ГНГ)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_CargoesHarmonizedNomenclature'
GO

SET ANSI_PADDING ON
GO
print 'TreeNSI_TransportRateClass - Единая тарифно-статистическая номенклатура грузов'
CREATE TABLE [dbo].[TreeNSI_TransportRateClass](
	[IdTransportRateClass] [int] IDENTITY(1,1) NOT NULL,
	[IsGroup] [bit] NOT NULL,
	[ParentId] [int] NULL,
	[Code] [varchar](6) NULL,
	[Name] [varchar](400) NOT NULL,
	[Class] [int] NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_TreeNSI_TransportRateClass] PRIMARY KEY CLUSTERED 
(
	[IdTransportRateClass] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_TransportRateClass', @level2type=N'COLUMN',@level2name=N'IdTransportRateClass'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Флаг группы' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_TransportRateClass', @level2type=N'COLUMN',@level2name=N'IsGroup'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код родителя' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_TransportRateClass', @level2type=N'COLUMN',@level2name=N'ParentId'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код ЕТСНГ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_TransportRateClass', @level2type=N'COLUMN',@level2name=N'Code'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Наименование' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_TransportRateClass', @level2type=N'COLUMN',@level2name=N'Name'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Тарифный класс груза' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_TransportRateClass', @level2type=N'COLUMN',@level2name=N'Class'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Активно' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_TransportRateClass', @level2type=N'COLUMN',@level2name=N'IsActive'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Единая тарифно-статистическая номенклатура грузов' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_TransportRateClass'
GO
/********************************************************************************************************************************************************************************************/
SET ANSI_PADDING ON
GO
print 'TreeNSI_Addr_AddressesClassifierBY_Locality - ОКРБ 003-94 "Общегосударственный классификатор "Система обозначений объектов административно-территориального деления и населенных пунктов"'
CREATE TABLE [dbo].[TreeNSI_Addr_AddressesClassifierBY_Locality](
	[IdAddrClassifierBY_Locality] [int] IDENTITY(1,1) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[Description] [varchar](250) NULL,
 CONSTRAINT [PK_TreeNSI_Addr_AddressesClassifierBY_Locality] PRIMARY KEY CLUSTERED 
(
	[IdAddrClassifierBY_Locality] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Addr_AddressesClassifierBY_Locality', @level2type=N'COLUMN',@level2name=N'IdAddrClassifierBY_Locality'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Активно' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Addr_AddressesClassifierBY_Locality', @level2type=N'COLUMN',@level2name=N'IsActive'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Описание' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Addr_AddressesClassifierBY_Locality', @level2type=N'COLUMN',@level2name=N'Description'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'ОКРБ 003-94 "Общегосударственный классификатор "Система обозначений объектов административно-территориального деления и населенных пунктов"' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Addr_AddressesClassifierBY_Locality'
GO

SET ANSI_PADDING ON
GO
print 'TreeNSI_Addr_AddressesClassifierBY_LocalityProperty - Характеристика СОАТО РБ'
CREATE TABLE [dbo].[TreeNSI_Addr_AddressesClassifierBY_LocalityProperty](
	[IdProperty] [int] IDENTITY(1,1) NOT NULL,
	[IdElement] [int] NOT NULL,
	[BeginDate] [date] NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[LocalityType] [varchar](50) NOT NULL,
	[Code] [varchar](10) NOT NULL,
	[EndDate] [date] NULL,
	[LocalityTypeCode] [varchar](3) NULL,
	[DistrictCode] [varchar](3) NULL,
	[DistrictName] [varchar](50) NULL,
	[RegionCode] [varchar](3) NULL,
	[RegionName] [varchar](50) NULL,
 CONSTRAINT [PK_TreeNSI_Addr_AddressesClassifierBY_LocalityProperty] PRIMARY KEY CLUSTERED 
(
	[IdProperty] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код записи' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Addr_AddressesClassifierBY_LocalityProperty', @level2type=N'COLUMN',@level2name=N'IdProperty'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код владельца' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Addr_AddressesClassifierBY_LocalityProperty', @level2type=N'COLUMN',@level2name=N'IdElement'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Дата начала действия' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Addr_AddressesClassifierBY_LocalityProperty', @level2type=N'COLUMN',@level2name=N'BeginDate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Наименование' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Addr_AddressesClassifierBY_LocalityProperty', @level2type=N'COLUMN',@level2name=N'Name'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Тип населенного пункта' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Addr_AddressesClassifierBY_LocalityProperty', @level2type=N'COLUMN',@level2name=N'LocalityType'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код СОАТО' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Addr_AddressesClassifierBY_LocalityProperty', @level2type=N'COLUMN',@level2name=N'Code'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Дата окончания дейчтвия значения' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Addr_AddressesClassifierBY_LocalityProperty', @level2type=N'COLUMN',@level2name=N'EndDate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код типа населенного пункта' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Addr_AddressesClassifierBY_LocalityProperty', @level2type=N'COLUMN',@level2name=N'LocalityTypeCode'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Шифр области местоположения' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Addr_AddressesClassifierBY_LocalityProperty', @level2type=N'COLUMN',@level2name=N'DistrictCode'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Область местоположения' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Addr_AddressesClassifierBY_LocalityProperty', @level2type=N'COLUMN',@level2name=N'DistrictName'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Шифр района местоположения' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Addr_AddressesClassifierBY_LocalityProperty', @level2type=N'COLUMN',@level2name=N'RegionCode'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Район местоположения' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Addr_AddressesClassifierBY_LocalityProperty', @level2type=N'COLUMN',@level2name=N'RegionName'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Характеристика СОАТО РБ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Addr_AddressesClassifierBY_LocalityProperty'
GO

SET ANSI_PADDING ON
GO
print 'TreeNSI_Addr_AddressesClassifierRU_Locality - Классификатор адресов Российской Федерации - населенные пункты'
CREATE TABLE [dbo].[TreeNSI_Addr_AddressesClassifierRU_Locality](
	[IdAddrClassifierRU_Locality] [int] IDENTITY(1,1) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[Description] [varchar](250) NULL,
 CONSTRAINT [PK_TreeNSI_Addr_AddressesClassifierRU_Locality] PRIMARY KEY CLUSTERED 
(
	[IdAddrClassifierRU_Locality] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Addr_AddressesClassifierRU_Locality', @level2type=N'COLUMN',@level2name=N'IdAddrClassifierRU_Locality'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Активно' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Addr_AddressesClassifierRU_Locality', @level2type=N'COLUMN',@level2name=N'IsActive'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Описание' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Addr_AddressesClassifierRU_Locality', @level2type=N'COLUMN',@level2name=N'Description'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Классификатор адресов Российской Федерации - населенные пункты' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Addr_AddressesClassifierRU_Locality'
GO

SET ANSI_PADDING ON
GO
print 'TreeNSI_Addr_AddressesClassifierRU_LocalityProperty - Характеристика Классификатора адресов Российской Федерации - населенных пунктов'
CREATE TABLE [dbo].[TreeNSI_Addr_AddressesClassifierRU_LocalityProperty](
	[IdProperty] [int] IDENTITY(1,1) NOT NULL,
	[IdElement] [int] NOT NULL,
	[BeginDate] [date] NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[LocalityType] [varchar](10) NOT NULL,
	[Code] [varchar](11) NOT NULL,
	[Postcode] [varchar](6) NULL,
	[ARCPSCode] [varchar](11) NULL,
	[Status] [int] NULL,
	[Version] [int] NOT NULL,
 CONSTRAINT [PK_TreeNSI_Addr_AddressesClassifierRU_LocalityProperty] PRIMARY KEY CLUSTERED 
(
	[IdProperty] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код записи' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Addr_AddressesClassifierRU_LocalityProperty', @level2type=N'COLUMN',@level2name=N'IdProperty'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код владельца' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Addr_AddressesClassifierRU_LocalityProperty', @level2type=N'COLUMN',@level2name=N'IdElement'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Дата начала действия' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Addr_AddressesClassifierRU_LocalityProperty', @level2type=N'COLUMN',@level2name=N'BeginDate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Наименование' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Addr_AddressesClassifierRU_LocalityProperty', @level2type=N'COLUMN',@level2name=N'Name'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Тип населенного пункта' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Addr_AddressesClassifierRU_LocalityProperty', @level2type=N'COLUMN',@level2name=N'LocalityType'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код КЛАДР' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Addr_AddressesClassifierRU_LocalityProperty', @level2type=N'COLUMN',@level2name=N'Code'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Почтовый индекс' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Addr_AddressesClassifierRU_LocalityProperty', @level2type=N'COLUMN',@level2name=N'Postcode'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код ОКАТО (Общеросийский классификатор объектов административно-территориального деления)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Addr_AddressesClassifierRU_LocalityProperty', @level2type=N'COLUMN',@level2name=N'ARCPSCode'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Статус объекта (определяет признак центра админитсративно-территориального образования)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Addr_AddressesClassifierRU_LocalityProperty', @level2type=N'COLUMN',@level2name=N'Status'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Номер версии' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Addr_AddressesClassifierRU_LocalityProperty', @level2type=N'COLUMN',@level2name=N'Version'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Характеристика Классификатора адресов Российской Федерации - населенных пунктов' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Addr_AddressesClassifierRU_LocalityProperty'
GO

SET ANSI_PADDING ON
GO
print 'TreeNSI_Addr_CountryAddressesClassifierLocality - Национальные классификаторы АТЕ'
CREATE TABLE [dbo].[TreeNSI_Addr_CountryAddressesClassifierLocality](
	[IdClassifier] [int] IDENTITY(1,1) NOT NULL,
	[IdCountry] [int] NOT NULL,
	[Name] [varchar](300) NOT NULL,
	[Acronim] [varchar](20) NULL,
	[TableName] [varchar](100) NULL,
	[KeyFieldName] [varchar](100) NULL,
 CONSTRAINT [PK_TreeNSI_Addr_CountryAddressesClassifierLocality] PRIMARY KEY CLUSTERED 
(
	[IdClassifier] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Addr_CountryAddressesClassifierLocality', @level2type=N'COLUMN',@level2name=N'IdClassifier'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код страны' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Addr_CountryAddressesClassifierLocality', @level2type=N'COLUMN',@level2name=N'IdCountry'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Наименование классификатора' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Addr_CountryAddressesClassifierLocality', @level2type=N'COLUMN',@level2name=N'Name'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Аббревиатура классификатора' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Addr_CountryAddressesClassifierLocality', @level2type=N'COLUMN',@level2name=N'Acronim'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Имя таблицы хранения данных' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Addr_CountryAddressesClassifierLocality', @level2type=N'COLUMN',@level2name=N'TableName'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Имя ключевого поля в таблице хранения данных' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Addr_CountryAddressesClassifierLocality', @level2type=N'COLUMN',@level2name=N'KeyFieldName'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Национальные классификаторы АТЕ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Addr_CountryAddressesClassifierLocality'
GO
/************************************************************************************************************************************************************************************************/
SET ANSI_PADDING ON
GO
print 'TreeNSI_Addr_AddressType - Тип адреса (вариант его использования)'
CREATE TABLE [dbo].[TreeNSI_Addr_AddressType](
	[IdAddressType] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_TreeNSI_Adrr_AddressType] PRIMARY KEY CLUSTERED 
(
	[IdAddressType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Addr_AddressType', @level2type=N'COLUMN',@level2name=N'IdAddressType'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Наименование' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Addr_AddressType', @level2type=N'COLUMN',@level2name=N'Name'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Тип адреса (вариант его использования)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Addr_AddressType'
GO

SET ANSI_PADDING ON
GO
print 'TreeNSI_Addr_AdministrativTerritorialUnitType - Тип административно-терретириальной единицы'
CREATE TABLE [dbo].[TreeNSI_Addr_AdministrativTerritorialUnitType](
	[IdATUType] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Acronim] [varchar](20) NULL,
	[DefaultOrder] [int] NULL,
	[DefaultPrefix] [int] NOT NULL,
 CONSTRAINT [PK_TreeNSI_Addr_AdministrativTerritorialUnitType] PRIMARY KEY CLUSTERED 
(
	[IdATUType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Addr_AdministrativTerritorialUnitType', @level2type=N'COLUMN',@level2name=N'IdATUType'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Наименование' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Addr_AdministrativTerritorialUnitType', @level2type=N'COLUMN',@level2name=N'Name'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Акроним' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Addr_AdministrativTerritorialUnitType', @level2type=N'COLUMN',@level2name=N'Acronim'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Порядок использования при составлении адресной строки' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Addr_AdministrativTerritorialUnitType', @level2type=N'COLUMN',@level2name=N'DefaultOrder'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Использовать Акроним как префикс(1), постфикс(0) или неиспользовать вообще (NULL)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Addr_AdministrativTerritorialUnitType', @level2type=N'COLUMN',@level2name=N'DefaultPrefix'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Тип административно-терретириальной единицы' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Addr_AdministrativTerritorialUnitType'
GO

SET ANSI_PADDING ON
GO
print 'TreeNSI_Addr_AdministrativTerritorialUnit - Административно-территориальные единицы стран и регионов'
CREATE TABLE [dbo].[TreeNSI_Addr_AdministrativTerritorialUnit](
	[IdATU] [int] IDENTITY(1,1) NOT NULL,
	[IdCountry] [int] NOT NULL,
	[IsGroup] [bit] NOT NULL,
	[ParentId] [int] NULL,
	[Name] [varchar](100) NOT NULL,
	[IdATUType] [int] NOT NULL,
 CONSTRAINT [PK_TreeNSI_Addr_AdministrativTerritorialUnit] PRIMARY KEY CLUSTERED 
(
	[IdATU] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Addr_AdministrativTerritorialUnit', @level2type=N'COLUMN',@level2name=N'IdATU'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код страны' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Addr_AdministrativTerritorialUnit', @level2type=N'COLUMN',@level2name=N'IdCountry'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Это группа' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Addr_AdministrativTerritorialUnit', @level2type=N'COLUMN',@level2name=N'IsGroup'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код родительской группы' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Addr_AdministrativTerritorialUnit', @level2type=N'COLUMN',@level2name=N'ParentId'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Наименование' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Addr_AdministrativTerritorialUnit', @level2type=N'COLUMN',@level2name=N'Name'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код типа АТЕ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Addr_AdministrativTerritorialUnit', @level2type=N'COLUMN',@level2name=N'IdATUType'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Административно-территориальные единицы стран и регионов' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Addr_AdministrativTerritorialUnit'
GO

SET ANSI_PADDING ON
GO
print 'TreeNSI_Addr_ATUTypeNationalData - Тип административно территориальной единацы  на различных языках'
CREATE TABLE [dbo].[TreeNSI_Addr_ATUTypeNationalData](
	[IdATUType] [int] NOT NULL,
	[IdLanguage] [int] NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Acronim] [varchar](20) NULL,
 CONSTRAINT [PK_TreeNSI_Addr_ATUTypeNationalData] PRIMARY KEY CLUSTERED 
(
	[IdATUType] ASC,
	[IdLanguage] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Addr_ATUTypeNationalData', @level2type=N'COLUMN',@level2name=N'IdATUType'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код национального языка' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Addr_ATUTypeNationalData', @level2type=N'COLUMN',@level2name=N'IdLanguage'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Наименование на национальном языке' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Addr_ATUTypeNationalData', @level2type=N'COLUMN',@level2name=N'Name'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Акроним на национальном языке' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Addr_ATUTypeNationalData', @level2type=N'COLUMN',@level2name=N'Acronim'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Тип административно территориальной единацы  на различных языках' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Addr_ATUTypeNationalData'
GO

SET ANSI_PADDING ON
GO
print 'TreeNSI_Addr_ATUNationalData - Наименование АТЕ стран и регионов на различных языках'
CREATE TABLE [dbo].[TreeNSI_Addr_ATUNationalData](
	[IdATU] [int] NOT NULL,
	[IdLanguage] [int] NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_TreeNSI_Addr_ATUNationalData] PRIMARY KEY CLUSTERED 
(
	[IdATU] ASC,
	[IdLanguage] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO


EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код АТЕ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Addr_ATUNationalData', @level2type=N'COLUMN',@level2name=N'IdATU'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код национального языка' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Addr_ATUNationalData', @level2type=N'COLUMN',@level2name=N'IdLanguage'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Наименование на национальном языке' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Addr_ATUNationalData', @level2type=N'COLUMN',@level2name=N'Name'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Наименование АТЕ стран и регионов на различных языках' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Addr_ATUNationalData'
GO

SET ANSI_PADDING ON
GO
print 'TreeNSI_Addr_Address - Справочник адресов'
CREATE TABLE [dbo].[TreeNSI_Addr_Address](
	[IdAddress] [int] IDENTITY(1,1) NOT NULL,
	[IdCountry] [int] NOT NULL,
	[IdATU] [int] NOT NULL,
	[ATUAddress] [varchar](100) NULL,
	[PostCode] [varchar](20) NULL,
	[ExtraInfo] [varchar](100) NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_TreeNSI_Addr_Address] PRIMARY KEY CLUSTERED 
(
	[IdAddress] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Addr_Address', @level2type=N'COLUMN',@level2name=N'IdAddress'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код страны' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Addr_Address', @level2type=N'COLUMN',@level2name=N'IdCountry'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код АТЕ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Addr_Address', @level2type=N'COLUMN',@level2name=N'IdATU'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Местоположение внутри АТЕ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Addr_Address', @level2type=N'COLUMN',@level2name=N'ATUAddress'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Индекс (почтовый)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Addr_Address', @level2type=N'COLUMN',@level2name=N'PostCode'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Дополнительная информация' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Addr_Address', @level2type=N'COLUMN',@level2name=N'ExtraInfo'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Активно' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Addr_Address', @level2type=N'COLUMN',@level2name=N'IsActive'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Справочник адресов' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Addr_Address'
GO

SET ANSI_PADDING ON
GO
print 'TreeNSI_Addr_AddressNationalData - Информация об адресах на различных языках'
CREATE TABLE [dbo].[TreeNSI_Addr_AddressNationalData](
	[IdAddress] [int] NOT NULL,
	[IdLanguage] [int] NOT NULL,
	[ATUAddress] [nvarchar](100) NULL,
	[ExtraInfo] [nvarchar](100) NULL,
 CONSTRAINT [PK_TreeNSI_Addr_AddressNationalData] PRIMARY KEY CLUSTERED 
(
	[IdAddress] ASC,
	[IdLanguage] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код адреса' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Addr_AddressNationalData', @level2type=N'COLUMN',@level2name=N'IdAddress'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код языка' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Addr_AddressNationalData', @level2type=N'COLUMN',@level2name=N'IdLanguage'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Местоположение внутри АТЕ на национальном языке' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Addr_AddressNationalData', @level2type=N'COLUMN',@level2name=N'ATUAddress'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Дополнительная информация на национальном языке' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Addr_AddressNationalData', @level2type=N'COLUMN',@level2name=N'ExtraInfo'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Информация об адресах на различных языках' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Addr_AddressNationalData'
GO

SET ANSI_PADDING ON
GO
print 'TreeNSI_Addr_CountryAddressSettings - Настройка отображения адресной строки отдельных стран мира'
CREATE TABLE [dbo].[TreeNSI_Addr_CountryAddressSettings](
	[IdAddressSettings] [int] IDENTITY(1,1) NOT NULL,
	[IdCountry] [int] NOT NULL,
	[IdAddressType] [int] NULL,
	[IdLanguage] [int] NULL,
	[StringFormat] [varchar](10) NULL,
	[BeginDate] [date] NOT NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_TreeNSI_Addr_CountryAddressSettings] PRIMARY KEY CLUSTERED 
(
	[IdAddressSettings] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Addr_CountryAddressSettings', @level2type=N'COLUMN',@level2name=N'IdAddressSettings'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код страны' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Addr_CountryAddressSettings', @level2type=N'COLUMN',@level2name=N'IdCountry'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Тип адреса' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Addr_CountryAddressSettings', @level2type=N'COLUMN',@level2name=N'IdAddressType'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Язык отображения как АТЕ так и типов АТЕ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Addr_CountryAddressSettings', @level2type=N'COLUMN',@level2name=N'IdLanguage'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Формат представления адресной строки (S{P}ACE): S-адресное пространство внутри АТЕ, P-Индекс, может и не указываться, A-АТЕ - построенный или по дефолту или по спец сортировке описатель АТЕ, C-наименование страны, E-Дополнительная информация по адресу' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Addr_CountryAddressSettings', @level2type=N'COLUMN',@level2name=N'StringFormat'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Дата начала действия' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Addr_CountryAddressSettings', @level2type=N'COLUMN',@level2name=N'BeginDate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Активно' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Addr_CountryAddressSettings', @level2type=N'COLUMN',@level2name=N'IsActive'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Настройка отображения адресной строки отдельных стран мира' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Addr_CountryAddressSettings'
GO

SET ANSI_PADDING ON
GO
print 'TreeNSI_Addr_CountryAddressSettingsOrderData - Порядок вхождения типов АТЕ в адресную строку'
CREATE TABLE [dbo].[TreeNSI_Addr_CountryAddressSettingsOrderData](
	[IdAddressSettings] [int] NOT NULL,
	[IdATUType] [int] NOT NULL,
	[Prefix] [int] NOT NULL,
	[OrderNumber] [int] NULL,
 CONSTRAINT [PK_TreeNSI_Addr_CountryAddressSettingsOrderData] PRIMARY KEY CLUSTERED 
(
	[IdAddressSettings] ASC,
	[IdATUType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код региональной настройки' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Addr_CountryAddressSettingsOrderData', @level2type=N'COLUMN',@level2name=N'IdAddressSettings'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код типа АТЕ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Addr_CountryAddressSettingsOrderData', @level2type=N'COLUMN',@level2name=N'IdATUType'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Использовать Акроним АТЕ как префикс(1), постфикс(0) или неиспользовать вообще (NULL)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Addr_CountryAddressSettingsOrderData', @level2type=N'COLUMN',@level2name=N'Prefix'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Порядковый номер типа АТЕ при построении адресной строки' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Addr_CountryAddressSettingsOrderData', @level2type=N'COLUMN',@level2name=N'OrderNumber'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Порядок вхождения типов АТЕ в адресную строку' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Addr_CountryAddressSettingsOrderData'
GO

/**********************************************************************************************************************************************************************************/
SET ANSI_PADDING ON
GO
print 'TreeNSI_DBUseForeignKey - Базы данных, где используются данные системы TreNSI'
CREATE TABLE [dbo].[TreeNSI_DBUseForeignKey](
	[IdDB] [int] IDENTITY(1,1) NOT NULL,
	[ServerName] [varchar](100) NOT NULL,
	[DBName] [varchar](100) NOT NULL,
	[SchemaName] [varchar](100) NOT NULL,
	[DBDescription] [varchar](250) NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_TreeNSI_DBUseForeignKey] PRIMARY KEY CLUSTERED 
(
	[IdDB] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код записи' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_DBUseForeignKey', @level2type=N'COLUMN',@level2name=N'IdDB'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Имя сервера' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_DBUseForeignKey', @level2type=N'COLUMN',@level2name=N'ServerName'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Имя БД' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_DBUseForeignKey', @level2type=N'COLUMN',@level2name=N'DBName'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Имя схемы' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_DBUseForeignKey', @level2type=N'COLUMN',@level2name=N'SchemaName'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Описание основных задач, решаемых в БД' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_DBUseForeignKey', @level2type=N'COLUMN',@level2name=N'DBDescription'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Активно' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_DBUseForeignKey', @level2type=N'COLUMN',@level2name=N'IsActive'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Базы данных, где используются данные системы TreNSI' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_DBUseForeignKey'
GO

SET ANSI_PADDING ON
GO
print 'TreeNSI_Users - Пользователи системы'
CREATE TABLE [dbo].[TreeNSI_Users](
	[IdUser] [int] IDENTITY(1,1) NOT NULL,
	[ADName] [varchar](70) NULL,
	[IsActive] [bit] NOT NULL,
	[ChangePasswordOnFirstLogon] [bit] NOT NULL,
	[StoredPassword] [nvarchar](max) NULL,
	[Discriminator] [nvarchar](128) NOT NULL,
	[FIO] [varchar](50) NOT NULL,
	[IdEmploy] [char](38) NULL,
	[IdRole] [int] NULL,
 CONSTRAINT [PK_TreeNSI_Users] PRIMARY KEY CLUSTERED 
(
	[IdUser] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код пользователя' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Users', @level2type=N'COLUMN',@level2name=N'IdUser'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Имя пользователя в AD' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Users', @level2type=N'COLUMN',@level2name=N'ADName'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Активный' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Users', @level2type=N'COLUMN',@level2name=N'IsActive'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'ФИО пользователя' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Users', @level2type=N'COLUMN',@level2name=N'FIO'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Индификатор пользователя как сотрудника предприятия' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Users', @level2type=N'COLUMN',@level2name=N'IdEmploy'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Роль пользователя в системе (не используется в SSM)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Users', @level2type=N'COLUMN',@level2name=N'IdRole'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Пользователи системы' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Users'
GO

SET ANSI_PADDING ON
GO
print 'TreeNSI_Roles - Роли пользователей в системе'
CREATE TABLE [dbo].[TreeNSI_Roles](
	[ID] [int] NOT NULL,
	[RoleName] [varchar](50) NULL,
 CONSTRAINT [PK_TreeNSI_Role] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код Роли пользователей в системе' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Roles', @level2type=N'COLUMN',@level2name=N'ID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Наименование роли пользователей в системе' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Roles', @level2type=N'COLUMN',@level2name=N'RoleName'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Роли пользователей в системе' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Roles'
GO

SET ANSI_PADDING ON
GO
print 'TreeNSI_ssmUserRoles - Набор ролей у пользователя'
CREATE TABLE [dbo].[TreeNSI_ssmUserRoles](
	[IdUser] [int] NOT NULL,
	[IdRole] [int] NOT NULL,
 CONSTRAINT [PK_dbo.TreeNSI_ssmUserRoles] PRIMARY KEY CLUSTERED 
(
	[IdUser] ASC,
	[IdRole] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO


EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Набор ролей у пользователя в SSM' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_ssmUserRoles'
GO

SET ANSI_PADDING ON
GO
print 'TreeNSI_DirectoryType - Виды справочников системы'
CREATE TABLE [dbo].[TreeNSI_DirectoryType](
	[IdDirectoryType] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](100) NOT NULL,
	[Description] [varchar](250) NULL,
	[TableName] [varchar](100) NOT NULL,
	[IsMultilevel] [bit] NOT NULL,
	[IsPeriodic] [bit] NOT NULL,
	[OnlyRegistation] [bit] NOT NULL,
	[IsBaseStructure] [bit] NULL,
 CONSTRAINT [PK_TreeNSI_DirectoryType] PRIMARY KEY CLUSTERED 
(
	[IdDirectoryType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код типа справочника' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_DirectoryType', @level2type=N'COLUMN',@level2name=N'IdDirectoryType'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Наименование справочника' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_DirectoryType', @level2type=N'COLUMN',@level2name=N'Name'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Описание справочника' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_DirectoryType', @level2type=N'COLUMN',@level2name=N'Description'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Имя таблицы хранения данных' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_DirectoryType', @level2type=N'COLUMN',@level2name=N'TableName'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Многоуровневый' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_DirectoryType', @level2type=N'COLUMN',@level2name=N'IsMultilevel'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Имеет периодические реквизиты' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_DirectoryType', @level2type=N'COLUMN',@level2name=N'IsPeriodic'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Только регистрируется (в системе TreeNSI элементы справочника только регистрируются, сами данные хранятся в локальной системе)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_DirectoryType', @level2type=N'COLUMN',@level2name=N'OnlyRegistation'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Имеет базовую структуру (имеет основные реквизиты простого справочника (наименование (полное), определитель в подчинении и периодике)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_DirectoryType', @level2type=N'COLUMN',@level2name=N'IsBaseStructure'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Виды справочников системы' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_DirectoryType'
GO

SET ANSI_PADDING ON
GO
print 'TreeNSI_EnterpriseInformationSystemMember - Элементы информационной системы предприятия'
CREATE TABLE [dbo].[TreeNSI_EnterpriseInformationSystemMember](
	[IdEISMember] [int] IDENTITY(1,1) NOT NULL,
	[EISMemberName] [varchar](100) NOT NULL,
	[HandbookName] [varchar](120) NOT NULL,
	[Source] [varchar](300) NULL,
	[KeyColumnName] [varchar](70) NULL,
	[KeyColumnType] [varchar](15) NULL,
	[IdDirectoryType] [int] NULL,
 CONSTRAINT [PK_TreeNSI_EnterpriseInformationSystemMember] PRIMARY KEY CLUSTERED 
(
	[IdEISMember] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_EnterpriseInformationSystemMember', @level2type=N'COLUMN',@level2name=N'IdEISMember'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Название АРМа, системы' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_EnterpriseInformationSystemMember', @level2type=N'COLUMN',@level2name=N'EISMemberName'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Название справочника АРМа, системы' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_EnterpriseInformationSystemMember', @level2type=N'COLUMN',@level2name=N'HandbookName'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Путь на таблицу, в которой храняться данные' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_EnterpriseInformationSystemMember', @level2type=N'COLUMN',@level2name=N'Source'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Имя ключевого поля в таблице-источнике' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_EnterpriseInformationSystemMember', @level2type=N'COLUMN',@level2name=N'KeyColumnName'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Тип ключевого поля в таблице-источнике' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_EnterpriseInformationSystemMember', @level2type=N'COLUMN',@level2name=N'KeyColumnType'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Вид справочника в системе TreeNSI' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_EnterpriseInformationSystemMember', @level2type=N'COLUMN',@level2name=N'IdDirectoryType'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Элементы информационной системы предприятия' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_EnterpriseInformationSystemMember'
GO

SET ANSI_PADDING ON
GO
print 'TreeNSI_serv_ErrorLog - Лог ошибок при работе процедур со справочниками'
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

SET ANSI_PADDING OFF
GO

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

SET ANSI_PADDING ON
GO
print 'TreeNSI_DirectoryCatalog - Каталог элементов справочников'
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

GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код регистрации' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_DirectoryCatalog', @level2type=N'COLUMN',@level2name=N'IdCatalog'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код типа справочника' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_DirectoryCatalog', @level2type=N'COLUMN',@level2name=N'IdDirectoryType'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Автор' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_DirectoryCatalog', @level2type=N'COLUMN',@level2name=N'IdAuthor'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Дата регистрации' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_DirectoryCatalog', @level2type=N'COLUMN',@level2name=N'RegistrationDate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Каталог элементов справочников' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_DirectoryCatalog'
GO

/****************************************************************************************************************************************************************/

SET ANSI_PADDING ON
GO
print 'TreeNSI_Nomenclature - Номенклатура материальных ценностей, продукции, товаров и услуг'
CREATE TABLE [dbo].[TreeNSI_Nomenclature](
	[IdNomenclature] [int] IDENTITY(1,1) NOT NULL,
	[IdCatalog] [int] NOT NULL,
	[IsGroup] [bit] NOT NULL,
	[ParentId] [int] NULL,
	[Name] [varchar](100) NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_TreeNSI_Nomenclature] PRIMARY KEY CLUSTERED 
(
	[IdNomenclature] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Nomenclature', @level2type=N'COLUMN',@level2name=N'IdNomenclature'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код каталога' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Nomenclature', @level2type=N'COLUMN',@level2name=N'IdCatalog'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Это группа' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Nomenclature', @level2type=N'COLUMN',@level2name=N'IsGroup'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код родительской группы' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Nomenclature', @level2type=N'COLUMN',@level2name=N'ParentId'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Наименование' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Nomenclature', @level2type=N'COLUMN',@level2name=N'Name'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Активно' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Nomenclature', @level2type=N'COLUMN',@level2name=N'IsActive'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Номенклатура материальных ценностей, продукции, товаров и услуг' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Nomenclature'
GO

SET ANSI_PADDING ON
GO
print 'TreeNSI_NomenclatureProperty - Характеристика номенклатурой единицы'
CREATE TABLE [dbo].[TreeNSI_NomenclatureProperty](
	[IdProperty] [int] IDENTITY(1,1) NOT NULL,
	[IdElement] [int] NOT NULL,
	[BeginDate] [date] NOT NULL,
	[FullName] [varchar](300) NULL,
	[IdClassProduct] [int] NULL,
	[IdCommonCustomsTariff] [int] NULL,
	[IdCargoesHarmonizedNomenclature] [int] NULL,
	[IdExciseGoodsGroup] [int] NULL,
	[IdTransportRateClass] [int] NULL,
 CONSTRAINT [PK_TreeNSI_NomenclatureProperty] PRIMARY KEY CLUSTERED 
(
	[IdProperty] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_NomenclatureProperty', @level2type=N'COLUMN',@level2name=N'IdProperty'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код владельца' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_NomenclatureProperty', @level2type=N'COLUMN',@level2name=N'IdElement'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Дата начала действия' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_NomenclatureProperty', @level2type=N'COLUMN',@level2name=N'BeginDate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Полное наименование' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_NomenclatureProperty', @level2type=N'COLUMN',@level2name=N'FullName'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код по Классификатору продукции по видам экономической деятельности' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_NomenclatureProperty', @level2type=N'COLUMN',@level2name=N'IdClassProduct'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код по Единому таможенному тарифу Евразийского экономического союза (ТН ВЭД)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_NomenclatureProperty', @level2type=N'COLUMN',@level2name=N'IdCommonCustomsTariff'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код по Гармонизированной номенклатуре грузов (ГНГ)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_NomenclatureProperty', @level2type=N'COLUMN',@level2name=N'IdCargoesHarmonizedNomenclature'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код группы подакцизных товаров' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_NomenclatureProperty', @level2type=N'COLUMN',@level2name=N'IdExciseGoodsGroup'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код По Единой тарифно-статистической номенклатуре грузов (ЕТСНГ)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_NomenclatureProperty', @level2type=N'COLUMN',@level2name=N'IdTransportRateClass'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Характеристика номенклатурой единицы' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_NomenclatureProperty'
GO

SET ANSI_PADDING ON
GO
print 'TreeNSI_NomenclatureProductProperty - Характеристика номенклатурой единицы как дискретного товара'
CREATE TABLE [dbo].[TreeNSI_NomenclatureProductProperty](
	[IdNomenclature] [int] NOT NULL,
	[GTINCode] [varchar](14) NULL,
	[MassVolumeMeashurementUnit] [int] NULL,
	[MassVolume] [decimal](9, 6) NULL,
 CONSTRAINT [PK_TreeNSI_NomenclatureProductProperty] PRIMARY KEY CLUSTERED 
(
	[IdNomenclature] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код номенклатуры' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_NomenclatureProductProperty', @level2type=N'COLUMN',@level2name=N'IdNomenclature'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Идентификационный номер GTIN' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_NomenclatureProductProperty', @level2type=N'COLUMN',@level2name=N'GTINCode'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Объемо-массовая характеристика: единица измерения' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_NomenclatureProductProperty', @level2type=N'COLUMN',@level2name=N'MassVolumeMeashurementUnit'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Объемо-массовая характеристика: значение массы нетто (объема)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_NomenclatureProductProperty', @level2type=N'COLUMN',@level2name=N'MassVolume'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Характеристика номенклатурой единицы как дискретного товара' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_NomenclatureProductProperty'
GO

SET ANSI_PADDING ON
GO
print 'TreeNSI_NomenclatureMeasurementUnit - Единицы измерения номенклатуры'
CREATE TABLE [dbo].[TreeNSI_NomenclatureMeasurementUnit](
	[IdNomenclatureMeasurementUnit] [int] IDENTITY(1,1) NOT NULL,
	[IdNomenclature] [int] NOT NULL,
	[IdMeasurementUnit] [int] NOT NULL,
	[IsBaseUnit] [bit] NOT NULL,
 CONSTRAINT [PK_TreeNSI_NomenclatureMeasurementUnit] PRIMARY KEY CLUSTERED 
(
	[IdNomenclatureMeasurementUnit] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_NomenclatureMeasurementUnit', @level2type=N'COLUMN',@level2name=N'IdNomenclatureMeasurementUnit'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код номенклатуры' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_NomenclatureMeasurementUnit', @level2type=N'COLUMN',@level2name=N'IdNomenclature'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код единицы измерения' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_NomenclatureMeasurementUnit', @level2type=N'COLUMN',@level2name=N'IdMeasurementUnit'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Основная единица измерения' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_NomenclatureMeasurementUnit', @level2type=N'COLUMN',@level2name=N'IsBaseUnit'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Единицы измерения номенклатуры' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_NomenclatureMeasurementUnit'
GO

SET ANSI_PADDING ON
GO
print 'TreeNSI_NomenclatureDangerousGoodProperty - Характеристика номенклатурой единицы как опасного груза'
CREATE TABLE [dbo].[TreeNSI_NomenclatureDangerousGoodProperty](
	[IdDangerousGoodProperty] [int] IDENTITY(1,1) NOT NULL,
	[IdNomenclature] [int] NOT NULL,
	[BeginDate] [date] NOT NULL,
	[IdRailwayDG] [int] NULL,
	[IdRBRailwayDG] [int] NULL,
	[IdRoadDG] [int] NULL,
 CONSTRAINT [PK_TreeNSI_NomenclatureDangerousGoodProperty] PRIMARY KEY CLUSTERED 
(
	[IdDangerousGoodProperty] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_NomenclatureDangerousGoodProperty', @level2type=N'COLUMN',@level2name=N'IdDangerousGoodProperty'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код номенклатуры' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_NomenclatureDangerousGoodProperty', @level2type=N'COLUMN',@level2name=N'IdNomenclature'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Дата начала действия' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_NomenclatureDangerousGoodProperty', @level2type=N'COLUMN',@level2name=N'BeginDate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код по Правилам перевозки ЖД транспортом опасных грузов (СМГС)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_NomenclatureDangerousGoodProperty', @level2type=N'COLUMN',@level2name=N'IdRailwayDG'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код по Правилам перевозки по РБ железодорожным транспортом опасных грузов' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_NomenclatureDangerousGoodProperty', @level2type=N'COLUMN',@level2name=N'IdRBRailwayDG'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код по Правилам перевозки автотранспортом опаснных грузов' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_NomenclatureDangerousGoodProperty', @level2type=N'COLUMN',@level2name=N'IdRoadDG'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Характеристика номенклатурой единицы как опасного груза' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_NomenclatureDangerousGoodProperty'
GO

SET ANSI_PADDING ON
GO
print 'TreeNSI_NomenclatureNormativeDocumentProperty - Нормативные документы номенклатурной единицы товаров и услуг'
CREATE TABLE [dbo].[TreeNSI_NomenclatureNormativeDocumentProperty](
	[IdNormativeDocumentProperty] [int] IDENTITY(1,1) NOT NULL,
	[IdNomenclature] [int] NOT NULL,
	[BeginDate] [date] NOT NULL,
	[IdNormativeDocument] [int] NOT NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_TreeNSI_NomenclatureNormativeDocumentProperty] PRIMARY KEY CLUSTERED 
(
	[IdNormativeDocumentProperty] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_NomenclatureNormativeDocumentProperty', @level2type=N'COLUMN',@level2name=N'IdNormativeDocumentProperty'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код номенклатуры' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_NomenclatureNormativeDocumentProperty', @level2type=N'COLUMN',@level2name=N'IdNomenclature'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Дата начала действия' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_NomenclatureNormativeDocumentProperty', @level2type=N'COLUMN',@level2name=N'BeginDate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код нормативного документа' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_NomenclatureNormativeDocumentProperty', @level2type=N'COLUMN',@level2name=N'IdNormativeDocument'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Активно' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_NomenclatureNormativeDocumentProperty', @level2type=N'COLUMN',@level2name=N'IsActive'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Нормативные документы номенклатурной единицы товаров и услуг' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_NomenclatureNormativeDocumentProperty'
GO

SET ANSI_PADDING ON
GO
print 'TreeNSI_NomenclatureType - Вид номенклатуры'
CREATE TABLE [dbo].[TreeNSI_NomenclatureType](
	[IdNomenclatureType] [int] IDENTITY(1,1) NOT NULL,
	[IsGroup] [bit] NOT NULL,
	[ParentId] [int] NULL,
	[Name] [varchar](100) NOT NULL,
	[Description] [varchar](250) NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_TreeNSI_NomenclatureType] PRIMARY KEY CLUSTERED 
(
	[IdNomenclatureType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_NomenclatureType', @level2type=N'COLUMN',@level2name=N'IdNomenclatureType'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Признак группы' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_NomenclatureType', @level2type=N'COLUMN',@level2name=N'IsGroup'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код родительской группы' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_NomenclatureType', @level2type=N'COLUMN',@level2name=N'ParentId'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Наименование' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_NomenclatureType', @level2type=N'COLUMN',@level2name=N'Name'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Описание' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_NomenclatureType', @level2type=N'COLUMN',@level2name=N'Description'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Активно' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_NomenclatureType', @level2type=N'COLUMN',@level2name=N'IsActive'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Вид номенклатуры' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_NomenclatureType'
GO

SET ANSI_PADDING ON
GO
print 'TreeNSI_Nomenclature_NoneclatureType - Возможные типы номенклатуры для элемента номенклатуры'
CREATE TABLE [dbo].[TreeNSI_Nomenclature_NoneclatureType](
	[IdNomenclature] [int] NOT NULL,
	[IdNomenclatureType] [int] NOT NULL,
 CONSTRAINT [PK_TreeNSI_Nomenclature_NoneclatureType] PRIMARY KEY CLUSTERED 
(
	[IdNomenclature] ASC,
	[IdNomenclatureType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код номенклатуры' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Nomenclature_NoneclatureType', @level2type=N'COLUMN',@level2name=N'IdNomenclature'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код типа номенклатуры' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Nomenclature_NoneclatureType', @level2type=N'COLUMN',@level2name=N'IdNomenclatureType'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Возможные типы номенклатуры для элемента номенклатуры' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Nomenclature_NoneclatureType'
GO

SET ANSI_PADDING ON
GO
print 'TreeNSI_Packaging - Тара и упаковка'
CREATE TABLE [dbo].[TreeNSI_Packaging](
	[IdPackaging] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](70) NOT NULL,
	[ShortName] [varchar](15) NULL,
	[IdNomenclature] [int] NULL,
	[ContainerSize] [int] NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_TreeNSI_Packaging] PRIMARY KEY CLUSTERED 
(
	[IdPackaging] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Packaging', @level2type=N'COLUMN',@level2name=N'IdPackaging'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Наименование' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Packaging', @level2type=N'COLUMN',@level2name=N'Name'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Краткое наименование' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Packaging', @level2type=N'COLUMN',@level2name=N'ShortName'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Номенклатура, ипсользуемая в качестве тары' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Packaging', @level2type=N'COLUMN',@level2name=N'IdNomenclature'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Объем тары (количество единиц в упаковке)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Packaging', @level2type=N'COLUMN',@level2name=N'ContainerSize'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Активно' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Packaging', @level2type=N'COLUMN',@level2name=N'IsActive'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Тара и упаковка' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Packaging'
GO

SET ANSI_PADDING ON
GO
print 'TreeNSI_Packaging_Nomenclature - Элементы номенклатуры, для которых используется тара'
CREATE TABLE [dbo].[TreeNSI_Packaging_Nomenclature](
	[IdPackaging] [int] NOT NULL,
	[IdNomenclature] [int] NOT NULL,
 CONSTRAINT [PK_TreeNSI_Packaging_Nomenclature] PRIMARY KEY CLUSTERED 
(
	[IdPackaging] ASC,
	[IdNomenclature] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код упаковки (тары)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Packaging_Nomenclature', @level2type=N'COLUMN',@level2name=N'IdPackaging'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код номенклатуры' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Packaging_Nomenclature', @level2type=N'COLUMN',@level2name=N'IdNomenclature'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Элементы номенклатуры, для которых используется тара' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Packaging_Nomenclature'
GO

SET ANSI_PADDING ON
GO
print 'TreeNSI_ConformityAttestationDocumentType - Типы документов, подтверждающих соответствие товаров и улуг'
CREATE TABLE [dbo].[TreeNSI_ConformityAttestationDocumentType](
	[IdCADocumentType] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](100) NOT NULL,
	[FullName] [varchar](200) NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_TreeNSI_ConformityAttestationDocumentType] PRIMARY KEY CLUSTERED 
(
	[IdCADocumentType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_ConformityAttestationDocumentType', @level2type=N'COLUMN',@level2name=N'IdCADocumentType'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Наименование' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_ConformityAttestationDocumentType', @level2type=N'COLUMN',@level2name=N'Name'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Полное наименование' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_ConformityAttestationDocumentType', @level2type=N'COLUMN',@level2name=N'FullName'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Активно (флаг используется для выбора в диалоге)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_ConformityAttestationDocumentType', @level2type=N'COLUMN',@level2name=N'IsActive'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Типы документов, подтверждающих соответствие товаров и улуг' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_ConformityAttestationDocumentType'
GO

SET ANSI_PADDING ON
GO
print 'TreeNSI_ConformityAttestationDocument - Документы, подтверждающие соответствие товаров и улуг'
CREATE TABLE [dbo].[TreeNSI_ConformityAttestationDocument](
	[IdCADocument] [int] IDENTITY(1,1) NOT NULL,
	[IdCADocumentType] [int] NOT NULL,
	[RegistrationNumber] [varchar](50) NOT NULL,
	[RegistrationDate] [date] NULL,
	[ValidityPeriod] [date] NULL,
	[IsActive] [bit] NOT NULL,
	[URLWebDocument] [nvarchar](250) NULL,
 CONSTRAINT [PK_TreeNSI_ConformityAttestationDocument] PRIMARY KEY CLUSTERED 
(
	[IdCADocument] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_ConformityAttestationDocument', @level2type=N'COLUMN',@level2name=N'IdCADocument'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Тип документа, подтверждающего соответствие товаров и услуг' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_ConformityAttestationDocument', @level2type=N'COLUMN',@level2name=N'IdCADocumentType'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Регистрационный номер' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_ConformityAttestationDocument', @level2type=N'COLUMN',@level2name=N'RegistrationNumber'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Дата регистрации' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_ConformityAttestationDocument', @level2type=N'COLUMN',@level2name=N'RegistrationDate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Период действия' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_ConformityAttestationDocument', @level2type=N'COLUMN',@level2name=N'ValidityPeriod'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Активно' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_ConformityAttestationDocument', @level2type=N'COLUMN',@level2name=N'IsActive'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'URL ссылка на документ в сети Internet' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_ConformityAttestationDocument', @level2type=N'COLUMN',@level2name=N'URLWebDocument'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Документы, подтверждающие соответствие товаров и улуг' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_ConformityAttestationDocument'
GO

SET ANSI_PADDING ON
GO
print 'TreeNSI_NomenclatureConformityAttestationDocumentProperty - Документы, подтверждающие соответсвиие номенклатурной единицы товарам и услугам'
CREATE TABLE [dbo].[TreeNSI_NomenclatureConformityAttestationDocumentProperty](
	[IdCADocumentProperty] [int] IDENTITY(1,1) NOT NULL,
	[IdNomenclature] [int] NOT NULL,
	[BeginDate] [date] NOT NULL,
	[IdCADocument] [int] NOT NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_TreeNSI_NomenclatureConformityAttestationDocumentProperty] PRIMARY KEY CLUSTERED 
(
	[IdCADocumentProperty] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_NomenclatureConformityAttestationDocumentProperty', @level2type=N'COLUMN',@level2name=N'IdCADocumentProperty'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код номенклатуры' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_NomenclatureConformityAttestationDocumentProperty', @level2type=N'COLUMN',@level2name=N'IdNomenclature'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Дата начала действия' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_NomenclatureConformityAttestationDocumentProperty', @level2type=N'COLUMN',@level2name=N'BeginDate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код документа, подтверждающего соответствие' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_NomenclatureConformityAttestationDocumentProperty', @level2type=N'COLUMN',@level2name=N'IdCADocument'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Активно' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_NomenclatureConformityAttestationDocumentProperty', @level2type=N'COLUMN',@level2name=N'IsActive'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Документы, подтверждающие соответсвиие номенклатурной единицы товарам и услугам' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_NomenclatureConformityAttestationDocumentProperty'
GO

SET ANSI_PADDING ON
GO
print 'TreeNSI_NomenclatureRecodeTable - Таблица соответствия кодов справочника Номенклатура кодам справочников Продуктов прочих систем'
CREATE TABLE [dbo].[TreeNSI_NomenclatureRecodeTable](
	[IdNomenclature] [int] NOT NULL,
	[IdEISMember] [int] NOT NULL,
	[EISCode] [varchar](32) NOT NULL,
 CONSTRAINT [PK_TreeNSI_NomenclatureRecodeTable] PRIMARY KEY CLUSTERED 
(
	[IdEISMember] ASC,
	[EISCode] ASC,
	[IdNomenclature] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Идентификатор элемента справочника Номенклатура' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_NomenclatureRecodeTable', @level2type=N'COLUMN',@level2name=N'IdNomenclature'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код задачи ИС предприятия' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_NomenclatureRecodeTable', @level2type=N'COLUMN',@level2name=N'IdEISMember'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Идентификатор элемента в справочнике Продуктов АРМа, системы' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_NomenclatureRecodeTable', @level2type=N'COLUMN',@level2name=N'EISCode'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Таблица соответствия кодов справочника Номенклатура кодам справочников Продуктов прочих систем' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_NomenclatureRecodeTable'
GO

/***************************************************************************************************************************************************************/
SET ANSI_PADDING ON
GO
print 'TreeNSI_Counteragent - Контрагенты: юридические лица, предприятия и организации'
CREATE TABLE [dbo].[TreeNSI_Counteragent](
	[IdCounteragent] [int] IDENTITY(1,1) NOT NULL,
	[IdCatalog] [int] NOT NULL,
	[IsGroup] [bit] NOT NULL,
	[ParentId] [int] NULL,
	[Name] [varchar](100) NULL,
	[IdCountry] [int] NOT NULL,
 CONSTRAINT [PK_TreeNSI_Counteragent] PRIMARY KEY CLUSTERED 
(
	[IdCounteragent] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Counteragent', @level2type=N'COLUMN',@level2name=N'IdCounteragent'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код каталога' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Counteragent', @level2type=N'COLUMN',@level2name=N'IdCatalog'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Это группа' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Counteragent', @level2type=N'COLUMN',@level2name=N'IsGroup'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код родительской группы' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Counteragent', @level2type=N'COLUMN',@level2name=N'ParentId'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Наименование' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Counteragent', @level2type=N'COLUMN',@level2name=N'Name'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код страны регистрации' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Counteragent', @level2type=N'COLUMN',@level2name=N'IdCountry'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Контрагенты: юридические лица, предприятия и организации' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Counteragent'
GO

SET ANSI_PADDING ON
GO
print 'TreeNSI_CounteragentProperty - Характеристика контрагента'
CREATE TABLE [dbo].[TreeNSI_CounteragentProperty](
	[IdProperty] [int] IDENTITY(1,1) NOT NULL,
	[IdElement] [int] NOT NULL,
	[BeginDate] [date] NOT NULL,
	[FullName] [varchar](300) NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_TreeNSI_CounteragentProperty] PRIMARY KEY CLUSTERED 
(
	[IdProperty] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_CounteragentProperty', @level2type=N'COLUMN',@level2name=N'IdProperty'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код владельца' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_CounteragentProperty', @level2type=N'COLUMN',@level2name=N'IdElement'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Дата начала действия' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_CounteragentProperty', @level2type=N'COLUMN',@level2name=N'BeginDate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Полное наименование' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_CounteragentProperty', @level2type=N'COLUMN',@level2name=N'FullName'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Активно' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_CounteragentProperty', @level2type=N'COLUMN',@level2name=N'IsActive'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Характеристика контрагента' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_CounteragentProperty'
GO

SET ANSI_PADDING ON
GO
print 'TreeNSI_CounteragentNationalData - Наименование контрагента на различных языках'
CREATE TABLE [dbo].[TreeNSI_CounteragentNationalData](
	[IdCounteragentNationalData] [int] IDENTITY(1,1) NOT NULL,
	[IdCounteragent] [int] NOT NULL,
	[IdLanguage] [int] NOT NULL,
	[FullName] [nvarchar](300) NOT NULL,
	[BeginDate] [date] NOT NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_TreeNSI_CounteragentNationalData] PRIMARY KEY CLUSTERED 
(
	[IdCounteragentNationalData] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_CounteragentNationalData', @level2type=N'COLUMN',@level2name=N'IdCounteragentNationalData'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код контрагента' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_CounteragentNationalData', @level2type=N'COLUMN',@level2name=N'IdCounteragent'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код национального языка' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_CounteragentNationalData', @level2type=N'COLUMN',@level2name=N'IdLanguage'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Полное наименование на национальном языке' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_CounteragentNationalData', @level2type=N'COLUMN',@level2name=N'FullName'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Дата начала действия' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_CounteragentNationalData', @level2type=N'COLUMN',@level2name=N'BeginDate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Активно' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_CounteragentNationalData', @level2type=N'COLUMN',@level2name=N'IsActive'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Наименование контрагента на различных языках' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_CounteragentNationalData'
GO

SET ANSI_PADDING ON
GO
print 'TreeNSI_CounteragentRegistrationNumbersType - Типы регистрации юридических лиц в странах'
CREATE TABLE [dbo].[TreeNSI_CounteragentRegistrationNumbersType](
	[IdRegNumberType] [int] IDENTITY(1,1) NOT NULL,
	[IdCountry] [int] NOT NULL,
	[Name] [varchar](150) NOT NULL,
	[ShortName] [varchar](20) NULL,
	[IsActive] [bit] NOT NULL,
	[IsMain] [bit] NOT NULL,
	[LenNumber] [int] NULL,
 CONSTRAINT [PK_TreeNSI_CounteragentRegistrationNumbersType] PRIMARY KEY CLUSTERED 
(
	[IdRegNumberType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_CounteragentRegistrationNumbersType', @level2type=N'COLUMN',@level2name=N'IdRegNumberType'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код страны' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_CounteragentRegistrationNumbersType', @level2type=N'COLUMN',@level2name=N'IdCountry'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Наименование' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_CounteragentRegistrationNumbersType', @level2type=N'COLUMN',@level2name=N'Name'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Аббревиатура' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_CounteragentRegistrationNumbersType', @level2type=N'COLUMN',@level2name=N'ShortName'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Активно (флаг используется для выбора в диалоге)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_CounteragentRegistrationNumbersType', @level2type=N'COLUMN',@level2name=N'IsActive'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Это основной регистрационный код' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_CounteragentRegistrationNumbersType', @level2type=N'COLUMN',@level2name=N'IsMain'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Длинна номера (для первичного контроля)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_CounteragentRegistrationNumbersType', @level2type=N'COLUMN',@level2name=N'LenNumber'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Типы регистрации юридических лиц в странах' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_CounteragentRegistrationNumbersType'
GO

SET ANSI_PADDING ON
GO
print 'TreeNSI_CounteragentRegistrationNumber - Коды регистрации контрагентов в их странах'
CREATE TABLE [dbo].[TreeNSI_CounteragentRegistrationNumber](
	[IdCounteragent] [int] NOT NULL,
	[IdRegNumberType] [int] NOT NULL,
	[Number] [varchar](20) NOT NULL,
 CONSTRAINT [PK_TreeNSI_CounteragentRegistrationNumber] PRIMARY KEY CLUSTERED 
(
	[IdCounteragent] ASC,
	[IdRegNumberType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Идентификатор элемента справочника Контрагенты' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_CounteragentRegistrationNumber', @level2type=N'COLUMN',@level2name=N'IdCounteragent'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Идентификатор типа регистрационного номера' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_CounteragentRegistrationNumber', @level2type=N'COLUMN',@level2name=N'IdRegNumberType'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Значение номера регистрации' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_CounteragentRegistrationNumber', @level2type=N'COLUMN',@level2name=N'Number'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Коды регистрации контрагентов в их странах' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_CounteragentRegistrationNumber'
GO

SET ANSI_PADDING ON
GO
print 'TreeNSI_CounteragentAddress - Адреса контрагента'
CREATE TABLE [dbo].[TreeNSI_CounteragentAddress](
	[IdCountragentAddress] [int] IDENTITY(1,1) NOT NULL,
	[IdCounteragent] [int] NOT NULL,
	[IdAddress] [int] NOT NULL,
	[IdAddressType] [int] NULL,
	[BeginDate] [date] NOT NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_TreeNSI_CounteragentAddress] PRIMARY KEY CLUSTERED 
(
	[IdCountragentAddress] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_CounteragentAddress', @level2type=N'COLUMN',@level2name=N'IdCountragentAddress'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код контрагента' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_CounteragentAddress', @level2type=N'COLUMN',@level2name=N'IdCounteragent'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Идентификатор адреса' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_CounteragentAddress', @level2type=N'COLUMN',@level2name=N'IdAddress'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код типа адреса' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_CounteragentAddress', @level2type=N'COLUMN',@level2name=N'IdAddressType'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Дата начала действия' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_CounteragentAddress', @level2type=N'COLUMN',@level2name=N'BeginDate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Активно' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_CounteragentAddress', @level2type=N'COLUMN',@level2name=N'IsActive'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Адреса контрагента' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_CounteragentAddress'
GO

SET ANSI_PADDING ON
GO
print 'TreeNSI_CounteragentAddressExtraInfo - Дополнительная информация для адреса контрагента'
CREATE TABLE [dbo].[TreeNSI_CounteragentAddressExtraInfo](
	[IdCountragentAddress] [int] NOT NULL,
	[ExtraInfo] [varchar](300) NULL,
 CONSTRAINT [PK_TreeNSI_CounteragentAddressExtraInfo] PRIMARY KEY CLUSTERED 
(
	[IdCountragentAddress] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код адреса контрагента' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_CounteragentAddressExtraInfo', @level2type=N'COLUMN',@level2name=N'IdCountragentAddress'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Дополнительная информация' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_CounteragentAddressExtraInfo', @level2type=N'COLUMN',@level2name=N'ExtraInfo'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Дополнительная информация для адреса контрагента' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_CounteragentAddressExtraInfo'
GO

SET ANSI_PADDING ON
GO
print 'TreeNSI_CounteragentContactDetails - Контактная информация контрагента'
CREATE TABLE [dbo].[TreeNSI_CounteragentContactDetails](
	[IdContactDetails] [int] IDENTITY(1,1) NOT NULL,
	[IdCounteragent] [int] NOT NULL,
	[PhoneNumber] [varchar](100) NULL,
	[Email] [nvarchar](100) NULL,
	[Web] [nvarchar](100) NULL,
	[ContactPerson] [varchar](100) NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_TreeNSI_CounteragentContactDetails] PRIMARY KEY CLUSTERED 
(
	[IdContactDetails] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_CounteragentContactDetails', @level2type=N'COLUMN',@level2name=N'IdContactDetails'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код контрагента' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_CounteragentContactDetails', @level2type=N'COLUMN',@level2name=N'IdCounteragent'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Контактные телефоны' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_CounteragentContactDetails', @level2type=N'COLUMN',@level2name=N'PhoneNumber'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Адрес электронной почты' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_CounteragentContactDetails', @level2type=N'COLUMN',@level2name=N'Email'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'WEB-сайт' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_CounteragentContactDetails', @level2type=N'COLUMN',@level2name=N'Web'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Контактное лицо' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_CounteragentContactDetails', @level2type=N'COLUMN',@level2name=N'ContactPerson'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Активно' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_CounteragentContactDetails', @level2type=N'COLUMN',@level2name=N'IsActive'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Контактная информация контрагента' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_CounteragentContactDetails'
GO

SET ANSI_PADDING ON
GO
print 'TreeNSI_CounteragentRecodeTable - Таблица соответствия кодов справочника Контрагенты (Юридические лица) кодам справочников Контрагентов прочих систем'
CREATE TABLE [dbo].[TreeNSI_CounteragentRecodeTable](
	[IdCounteragent] [int] NOT NULL,
	[IdEISMember] [int] NOT NULL,
	[EISCode] [varchar](32) NOT NULL,
 CONSTRAINT [PK_TreeNSI_CounteragentRecodeTable] PRIMARY KEY CLUSTERED 
(
	[IdEISMember] ASC,
	[EISCode] ASC,
	[IdCounteragent] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Идентификатор элемента справочника Контрагенты' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_CounteragentRecodeTable', @level2type=N'COLUMN',@level2name=N'IdCounteragent'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код Задачи ИС предприятия' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_CounteragentRecodeTable', @level2type=N'COLUMN',@level2name=N'IdEISMember'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Идентификатор элемента в справочнике Контрагентов АРМа, системы' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_CounteragentRecodeTable', @level2type=N'COLUMN',@level2name=N'EISCode'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Таблица соответствия кодов справочника Контрагенты (Юридические лица) кодам справочников Контрагентов прочих систем' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_CounteragentRecodeTable'
GO

/************************************************************************************************************************************************************/
SET ANSI_PADDING ON
GO
print 'TreeNSI_Subdivision - Структурные подразделения организации'
CREATE TABLE [dbo].[TreeNSI_Subdivision](
	[IdSubdivision] [int] IDENTITY(1,1) NOT NULL,
	[IdCatalog] [int] NOT NULL,
	[IsGroup] [bit] NOT NULL,
	[ParentId] [int] NULL,
	[Name] [varchar](100) NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_TreeNSI_Subdivision] PRIMARY KEY CLUSTERED 
(
	[IdSubdivision] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Subdivision', @level2type=N'COLUMN',@level2name=N'IdSubdivision'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код каталога' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Subdivision', @level2type=N'COLUMN',@level2name=N'IdCatalog'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Это группа' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Subdivision', @level2type=N'COLUMN',@level2name=N'IsGroup'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код родительской группы' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Subdivision', @level2type=N'COLUMN',@level2name=N'ParentId'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Наименование' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Subdivision', @level2type=N'COLUMN',@level2name=N'Name'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Активно' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Subdivision', @level2type=N'COLUMN',@level2name=N'IsActive'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Структурные подразделения организации' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Subdivision'
GO

SET ANSI_PADDING ON
GO
print 'TreeNSI_SubdivisionProperty - Характеристика структурной единицы организации'
CREATE TABLE [dbo].[TreeNSI_SubdivisionProperty](
	[IdProperty] [int] IDENTITY(1,1) NOT NULL,
	[IdElement] [int] NOT NULL,
	[BeginDate] [date] NOT NULL,
	[FullName] [varchar](300) NULL,
 CONSTRAINT [PK_TreeNSI_SubdivisionProperty] PRIMARY KEY CLUSTERED 
(
	[IdProperty] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_SubdivisionProperty', @level2type=N'COLUMN',@level2name=N'IdProperty'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код владельца' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_SubdivisionProperty', @level2type=N'COLUMN',@level2name=N'IdElement'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Дата начала действия' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_SubdivisionProperty', @level2type=N'COLUMN',@level2name=N'BeginDate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Полное наименование' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_SubdivisionProperty', @level2type=N'COLUMN',@level2name=N'FullName'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Характеристика структурной единицы организации' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_SubdivisionProperty'
GO

/*****************************************************************************************************************************************/
SET ANSI_PADDING ON
GO
print 'TreeNSI_IndustrialUnit - Промышленные утановки, резервуарные парки, склады хранения'
CREATE TABLE [dbo].[TreeNSI_IndustrialUnit](
	[IdIndustrialUnit] [int] IDENTITY(1,1) NOT NULL,
	[IdCatalog] [int] NOT NULL,
	[IsGroup] [bit] NOT NULL,
	[ParentId] [int] NULL,
	[Name] [varchar](100) NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_TreeNSI_IndustrialUnit] PRIMARY KEY CLUSTERED 
(
	[IdIndustrialUnit] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_IndustrialUnit', @level2type=N'COLUMN',@level2name=N'IdIndustrialUnit'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код каталога' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_IndustrialUnit', @level2type=N'COLUMN',@level2name=N'IdCatalog'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Это группа' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_IndustrialUnit', @level2type=N'COLUMN',@level2name=N'IsGroup'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код родительской группы' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_IndustrialUnit', @level2type=N'COLUMN',@level2name=N'ParentId'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Наименование' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_IndustrialUnit', @level2type=N'COLUMN',@level2name=N'Name'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Активно' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_IndustrialUnit', @level2type=N'COLUMN',@level2name=N'IsActive'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Промышленные утановки, резервуарные парки, склады хранения' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_IndustrialUnit'
GO

SET ANSI_PADDING ON
GO
print 'TreeNSI_IndustrialUnitProperty - Характеристика промышденной установки, резервуарного парка, склада хранения'
CREATE TABLE [dbo].[TreeNSI_IndustrialUnitProperty](
	[IdProperty] [int] IDENTITY(1,1) NOT NULL,
	[IdElement] [int] NOT NULL,
	[BeginDate] [date] NOT NULL,
	[FullName] [varchar](500) NULL,
 CONSTRAINT [PK_TreeNSI_IndustrialUnitProperty] PRIMARY KEY CLUSTERED 
(
	[IdProperty] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_IndustrialUnitProperty', @level2type=N'COLUMN',@level2name=N'IdProperty'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код владельца' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_IndustrialUnitProperty', @level2type=N'COLUMN',@level2name=N'IdElement'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Дата начала действия' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_IndustrialUnitProperty', @level2type=N'COLUMN',@level2name=N'BeginDate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Полное наименование' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_IndustrialUnitProperty', @level2type=N'COLUMN',@level2name=N'FullName'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Характеристика промышденной установки, резервуарного парка, склада хранения' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_IndustrialUnitProperty'
GO

/***********************************************************************************************************************************************************/
SET ANSI_PADDING ON
GO
print 'TreeNSI_IndustrialUnitModule - Блок, резервуар, емкость промышленной утановки, резервуарного парка'
CREATE TABLE [dbo].[TreeNSI_IndustrialUnitModule](
	[IdIndustrialUnitModule] [int] IDENTITY(1,1) NOT NULL,
	[IdCatalog] [int] NOT NULL,
	[IsGroup] [bit] NOT NULL,
	[ParentId] [int] NULL,
	[Name] [varchar](100) NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_TreeNSI_IndustrialUnitModule] PRIMARY KEY CLUSTERED 
(
	[IdIndustrialUnitModule] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_IndustrialUnitModule', @level2type=N'COLUMN',@level2name=N'IdIndustrialUnitModule'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код каталога' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_IndustrialUnitModule', @level2type=N'COLUMN',@level2name=N'IdCatalog'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Это группа' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_IndustrialUnitModule', @level2type=N'COLUMN',@level2name=N'IsGroup'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код родительской группы' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_IndustrialUnitModule', @level2type=N'COLUMN',@level2name=N'ParentId'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Наименование' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_IndustrialUnitModule', @level2type=N'COLUMN',@level2name=N'Name'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Активно' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_IndustrialUnitModule', @level2type=N'COLUMN',@level2name=N'IsActive'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Блок, резервуар, емкость промышленной утановки, резервуарного парка' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_IndustrialUnitModule'
GO

SET ANSI_PADDING ON
GO
print 'TreeNSI_IndustrialUnitModuleProperty - Характеристика блока, резервуара промышленной установки, резервуарного парка, склада хранения'
CREATE TABLE [dbo].[TreeNSI_IndustrialUnitModuleProperty](
	[IdProperty] [int] IDENTITY(1,1) NOT NULL,
	[IdElement] [int] NOT NULL,
	[BeginDate] [date] NOT NULL,
	[FullName] [varchar](300) NULL,
 CONSTRAINT [PK_TreeNSI_IndustrialUnitModuleProperty] PRIMARY KEY CLUSTERED 
(
	[IdProperty] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_IndustrialUnitModuleProperty', @level2type=N'COLUMN',@level2name=N'IdProperty'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код владельца' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_IndustrialUnitModuleProperty', @level2type=N'COLUMN',@level2name=N'IdElement'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Дата начала действия' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_IndustrialUnitModuleProperty', @level2type=N'COLUMN',@level2name=N'BeginDate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Полное наименование' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_IndustrialUnitModuleProperty', @level2type=N'COLUMN',@level2name=N'FullName'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Характеристика блока, резервуара промышленной установки, резервуарного парка, склада хранения' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_IndustrialUnitModuleProperty'
GO

/*********************************************************************************************************************************************************/
SET ANSI_PADDING ON
GO
print 'TreeNSI_ProcessingStep - Технологические переходы'
CREATE TABLE [dbo].[TreeNSI_ProcessingStep](
	[IdProcessingStep] [int] IDENTITY(1,1) NOT NULL,
	[IdCatalog] [int] NOT NULL,
	[IsGroup] [bit] NOT NULL,
	[ParentId] [int] NULL,
	[Name] [varchar](100) NOT NULL,
	[FullName] [varchar](300) NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_TreeNSI_ProcessingStep] PRIMARY KEY CLUSTERED 
(
	[IdProcessingStep] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_ProcessingStep', @level2type=N'COLUMN',@level2name=N'IdProcessingStep'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код каталога' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_ProcessingStep', @level2type=N'COLUMN',@level2name=N'IdCatalog'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Это группа' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_ProcessingStep', @level2type=N'COLUMN',@level2name=N'IsGroup'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код родительской группы' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_ProcessingStep', @level2type=N'COLUMN',@level2name=N'ParentId'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Наименование' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_ProcessingStep', @level2type=N'COLUMN',@level2name=N'Name'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Полное наименование' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_ProcessingStep', @level2type=N'COLUMN',@level2name=N'FullName'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Активно' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_ProcessingStep', @level2type=N'COLUMN',@level2name=N'IsActive'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Технологические переходы' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_ProcessingStep'
GO

/**********************************************************************************************************************************************************************************/
SET ANSI_PADDING ON
GO
print 'TreeNSI_IndustrialProcessesUnitOwner - Принадлежность элементов производственного просса'
CREATE TABLE [dbo].[TreeNSI_IndustrialProcessesUnitOwner](
	[IdIndustrialProcessesUnitOwner] [int] IDENTITY(1,1) NOT NULL,
	[IdIndustrialProcessesUnit] [int] NOT NULL,
	[IdCatalogOwner] [int] NULL,
	[BeginDate] [date] NOT NULL,
 CONSTRAINT [PK_TreeNSI_IndustrialProcessesUnitOwner] PRIMARY KEY CLUSTERED 
(
	[IdIndustrialProcessesUnitOwner] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_IndustrialProcessesUnitOwner', @level2type=N'COLUMN',@level2name=N'IdIndustrialProcessesUnitOwner'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код регистрации единицы производственного процесса' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_IndustrialProcessesUnitOwner', @level2type=N'COLUMN',@level2name=N'IdIndustrialProcessesUnit'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код регистрации объекта, которому принадлежит элемент' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_IndustrialProcessesUnitOwner', @level2type=N'COLUMN',@level2name=N'IdCatalogOwner'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Дата начала действия' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_IndustrialProcessesUnitOwner', @level2type=N'COLUMN',@level2name=N'BeginDate'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Принадлежность элементов производственного просса' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_IndustrialProcessesUnitOwner'
GO

/**********************************************************************************************************************************************************************************/
SET ANSI_PADDING ON
GO
print 'TreeNSI_Bank - Финансовая организация, банк'
CREATE TABLE [dbo].[TreeNSI_Bank](
	[IdBank] [int] IDENTITY(1,1) NOT NULL,
	[IdCounteragent] [int] NULL,
	[LocalRegistrationCode] [nvarchar](15) NULL,
	[SSWIFT_BIC] [nvarchar](15) NULL,
 CONSTRAINT [PK_dbo.TreeNSI_Bank] PRIMARY KEY CLUSTERED 
(
	[IdBank] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Bank', @level2type=N'COLUMN',@level2name=N'IdBank'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Банк как контрагент' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Bank', @level2type=N'COLUMN',@level2name=N'IdCounteragent'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код регистрации банка в его стране' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Bank', @level2type=N'COLUMN',@level2name=N'LocalRegistrationCode'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'SSWIFT BIC' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Bank', @level2type=N'COLUMN',@level2name=N'SSWIFT_BIC'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Финансовая организация, банк' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_Bank'
GO

SET ANSI_PADDING ON
GO
print 'TreeNSI_BankAccount - Расчетные счета контрагентов'
CREATE TABLE [dbo].[TreeNSI_BankAccount](
	[IdBankAccount] [int] IDENTITY(1,1) NOT NULL,
	[IdBank] [int] NOT NULL,
	[IdCounteragent] [int] NOT NULL,
	[Number] [nvarchar](34) NULL,
	[NumberIBAN] [nvarchar](34) NULL,
	[IdCurrency] [int] NOT NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_dbo.TreeNSI_BankAccount] PRIMARY KEY CLUSTERED 
(
	[IdBankAccount] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Индетификатор' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_BankAccount', @level2type=N'COLUMN',@level2name=N'IdBankAccount'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Банк' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_BankAccount', @level2type=N'COLUMN',@level2name=N'IdBank'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Код Контрагента' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_BankAccount', @level2type=N'COLUMN',@level2name=N'IdCounteragent'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Номер счета' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_BankAccount', @level2type=N'COLUMN',@level2name=N'Number'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Номер IBAN' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_BankAccount', @level2type=N'COLUMN',@level2name=N'NumberIBAN'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Валюта' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_BankAccount', @level2type=N'COLUMN',@level2name=N'IdCurrency'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Активно' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_BankAccount', @level2type=N'COLUMN',@level2name=N'IsActive'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_DESCRIPTION', @value=N'Финансовая организация, банк' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TreeNSI_BankAccount'
GO

/***************************************************************************************************************************/
print 'Создание CONSTRAINTS...'

print 'Создание CONSTRAINT FK_dbo.TreeNSI_MeasurementUnit_dbo.TreeNSI_MeasurementUnit_ParentId'
ALTER TABLE [dbo].[TreeNSI_MeasurementUnit]  WITH CHECK ADD  CONSTRAINT [FK_dbo.TreeNSI_MeasurementUnit_dbo.TreeNSI_MeasurementUnit_ParentId] FOREIGN KEY([ParentId])
REFERENCES [dbo].[TreeNSI_MeasurementUnit] ([IdMeasurementUnit])
GO

ALTER TABLE [dbo].[TreeNSI_MeasurementUnit] CHECK CONSTRAINT [FK_dbo.TreeNSI_MeasurementUnit_dbo.TreeNSI_MeasurementUnit_ParentId]
GO

print 'Создание CONSTRAINT FK_TreeNSI_CountryProperty_Country'
ALTER TABLE [dbo].[TreeNSI_CountryProperty]  WITH CHECK ADD  CONSTRAINT [FK_TreeNSI_CountryProperty_Country] FOREIGN KEY([IdElement])
REFERENCES [dbo].[TreeNSI_Country] ([IdCountry])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[TreeNSI_CountryProperty] CHECK CONSTRAINT [FK_TreeNSI_CountryProperty_Country]
GO

print 'Создание CONSTRAINT FK_TreeNSI_CountryNationalData_Country'
ALTER TABLE [dbo].[TreeNSI_CountryNationalData]  WITH CHECK ADD  CONSTRAINT [FK_TreeNSI_CountryNationalData_Country] FOREIGN KEY([IdCountry])
REFERENCES [dbo].[TreeNSI_Country] ([IdCountry])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[TreeNSI_CountryNationalData] CHECK CONSTRAINT [FK_TreeNSI_CountryNationalData_Country]
GO

print 'Создание CONSTRAINT FK_TreeNSI_CountryNationalData_NationalLanguage'
ALTER TABLE [dbo].[TreeNSI_CountryNationalData]  WITH CHECK ADD  CONSTRAINT [FK_TreeNSI_CountryNationalData_NationalLanguage] FOREIGN KEY([IdLanguage])
REFERENCES [dbo].[TreeNSI_NationalLanguage] ([IdLanguage])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[TreeNSI_CountryNationalData] CHECK CONSTRAINT [FK_TreeNSI_CountryNationalData_NationalLanguage]
GO

print 'Создание CONSTRAINT FK_TreeNSI_CountryUnionMember_TreeNSI_Country'
ALTER TABLE [dbo].[TreeNSI_CountryUnionMember]  WITH CHECK ADD  CONSTRAINT [FK_TreeNSI_CountryUnionMember_TreeNSI_Country] FOREIGN KEY([IdCountry])
REFERENCES [dbo].[TreeNSI_Country] ([IdCountry])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[TreeNSI_CountryUnionMember] CHECK CONSTRAINT [FK_TreeNSI_CountryUnionMember_TreeNSI_Country]
GO

print 'Создание CONSTRAINT FK_TreeNSI_CountryUnionMember_TreeNSI_CountryUnion'
ALTER TABLE [dbo].[TreeNSI_CountryUnionMember]  WITH CHECK ADD  CONSTRAINT [FK_TreeNSI_CountryUnionMember_TreeNSI_CountryUnion] FOREIGN KEY([IdCountryUnion])
REFERENCES [dbo].[TreeNSI_CountryUnion] ([IdCountryUnion])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[TreeNSI_CountryUnionMember] CHECK CONSTRAINT [FK_TreeNSI_CountryUnionMember_TreeNSI_CountryUnion]
GO

print 'Создание CONSTRAINT FK_dbo.TreeNSI_CurrencyProperty_dbo.TreeNSI_Currency_IdElement'
ALTER TABLE [dbo].[TreeNSI_CurrencyProperty]  WITH CHECK ADD  CONSTRAINT [FK_dbo.TreeNSI_CurrencyProperty_dbo.TreeNSI_Currency_IdElement] FOREIGN KEY([IdElement])
REFERENCES [dbo].[TreeNSI_Currency] ([IdCurrency])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[TreeNSI_CurrencyProperty] CHECK CONSTRAINT [FK_dbo.TreeNSI_CurrencyProperty_dbo.TreeNSI_Currency_IdElement]
GO

print 'Создание CONSTRAINT FK_TreeNSI_RailwayCountry_TreeNSI_Country'
ALTER TABLE [dbo].[TreeNSI_RailwayCountry]  WITH CHECK ADD  CONSTRAINT [FK_TreeNSI_RailwayCountry_TreeNSI_Country] FOREIGN KEY([IdCountry])
REFERENCES [dbo].[TreeNSI_Country] ([IdCountry])
GO

ALTER TABLE [dbo].[TreeNSI_RailwayCountry] CHECK CONSTRAINT [FK_TreeNSI_RailwayCountry_TreeNSI_Country]
GO

print 'Создание CONSTRAINT FK_TreeNSI_RailwayCountryProperty_TreeNSI_RailwayCountry'
ALTER TABLE [dbo].[TreeNSI_RailwayCountryProperty]  WITH CHECK ADD  CONSTRAINT [FK_TreeNSI_RailwayCountryProperty_TreeNSI_RailwayCountry] FOREIGN KEY([IdElement])
REFERENCES [dbo].[TreeNSI_RailwayCountry] ([IdRailwayCountry])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[TreeNSI_RailwayCountryProperty] CHECK CONSTRAINT [FK_TreeNSI_RailwayCountryProperty_TreeNSI_RailwayCountry]
GO

print 'Создание CONSTRAINT FK_TreeNSI_RailwayCompany_TreeNSI_Country'
ALTER TABLE [dbo].[TreeNSI_RailwayCompany]  WITH CHECK ADD  CONSTRAINT [FK_TreeNSI_RailwayCompany_TreeNSI_Country] FOREIGN KEY([IdCountry])
REFERENCES [dbo].[TreeNSI_Country] ([IdCountry])
GO

ALTER TABLE [dbo].[TreeNSI_RailwayCompany] CHECK CONSTRAINT [FK_TreeNSI_RailwayCompany_TreeNSI_Country]
GO

print 'Создание CONSTRAINT FK_TreeNSI_RailwayCompanyTranslitName_TreeNSI_RailwayCompany'
ALTER TABLE [dbo].[TreeNSI_RailwayCompanyTranslitName]  WITH CHECK ADD  CONSTRAINT [FK_TreeNSI_RailwayCompanyTranslitName_TreeNSI_RailwayCompany] FOREIGN KEY([IdRailwayCompany])
REFERENCES [dbo].[TreeNSI_RailwayCompany] ([IdRailwayCompany])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[TreeNSI_RailwayCompanyTranslitName] CHECK CONSTRAINT [FK_TreeNSI_RailwayCompanyTranslitName_TreeNSI_RailwayCompany]
GO

print 'Создание CONSTRAINT FK_TreeNSI_RailwayAdministration_TreeNSI_RailwayCompany'
ALTER TABLE [dbo].[TreeNSI_RailwayAdministration]  WITH CHECK ADD  CONSTRAINT [FK_TreeNSI_RailwayAdministration_TreeNSI_RailwayCompany] FOREIGN KEY([IdRailwayCompany])
REFERENCES [dbo].[TreeNSI_RailwayCompany] ([IdRailwayCompany])
GO

ALTER TABLE [dbo].[TreeNSI_RailwayAdministration] CHECK CONSTRAINT [FK_TreeNSI_RailwayAdministration_TreeNSI_RailwayCompany]
GO

print 'Создание CONSTRAINT FK_TreeNSI_RailwayStantion_TreeNSI_RailwayCountry'
ALTER TABLE [dbo].[TreeNSI_RailwayStantion]  WITH CHECK ADD  CONSTRAINT [FK_TreeNSI_RailwayStantion_TreeNSI_RailwayCountry] FOREIGN KEY([IdRailwayCountry])
REFERENCES [dbo].[TreeNSI_RailwayCountry] ([IdRailwayCountry])
GO

ALTER TABLE [dbo].[TreeNSI_RailwayStantion] CHECK CONSTRAINT [FK_TreeNSI_RailwayStantion_TreeNSI_RailwayCountry]
GO

print 'Создание CONSTRAINT FK_TreeNSI_RailwayStantionNationalData_TreeNSI_NationalLanguage'
ALTER TABLE [dbo].[TreeNSI_RailwayStantionNationalData]  WITH CHECK ADD  CONSTRAINT [FK_TreeNSI_RailwayStantionNationalData_TreeNSI_NationalLanguage] FOREIGN KEY([IdLanguage])
REFERENCES [dbo].[TreeNSI_NationalLanguage] ([IdLanguage])
GO

ALTER TABLE [dbo].[TreeNSI_RailwayStantionNationalData] CHECK CONSTRAINT [FK_TreeNSI_RailwayStantionNationalData_TreeNSI_NationalLanguage]
GO

print 'Создание CONSTRAINT FK_TreeNSI_RailwayStantionNationalData_TreeNSI_RailwayStantion'
ALTER TABLE [dbo].[TreeNSI_RailwayStantionNationalData]  WITH CHECK ADD  CONSTRAINT [FK_TreeNSI_RailwayStantionNationalData_TreeNSI_RailwayStantion] FOREIGN KEY([IdRailwayStantion])
REFERENCES [dbo].[TreeNSI_RailwayStantion] ([IdRailwayStantion])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[TreeNSI_RailwayStantionNationalData] CHECK CONSTRAINT [FK_TreeNSI_RailwayStantionNationalData_TreeNSI_RailwayStantion]
GO

print 'Создание CONSTRAINT FK_TreeNSI_RailwayStantionTranslit_TreeNSI_RailwayStantion'
ALTER TABLE [dbo].[TreeNSI_RailwayStantionTranslit]  WITH CHECK ADD  CONSTRAINT [FK_TreeNSI_RailwayStantionTranslit_TreeNSI_RailwayStantion] FOREIGN KEY([IdRailwayStantion])
REFERENCES [dbo].[TreeNSI_RailwayStantion] ([IdRailwayStantion])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[TreeNSI_RailwayStantionTranslit] CHECK CONSTRAINT [FK_TreeNSI_RailwayStantionTranslit_TreeNSI_RailwayStantion]
GO

print 'Создание CONSTRAINT FK_TreeNSI_RailwayBorderPointMembers_TreeNSI_RailwayBorderPoint'
ALTER TABLE [dbo].[TreeNSI_RailwayBorderPointMembers]  WITH CHECK ADD  CONSTRAINT [FK_TreeNSI_RailwayBorderPointMembers_TreeNSI_RailwayBorderPoint] FOREIGN KEY([IdRailwayBorderPoint])
REFERENCES [dbo].[TreeNSI_RailwayBorderPoint] ([IdRailwayBorderPoint])
GO

ALTER TABLE [dbo].[TreeNSI_RailwayBorderPointMembers] CHECK CONSTRAINT [FK_TreeNSI_RailwayBorderPointMembers_TreeNSI_RailwayBorderPoint]
GO

print 'Создание CONSTRAINT FK_TreeNSI_RailwayBorderPointMembers_TreeNSI_RailwayStantion'
ALTER TABLE [dbo].[TreeNSI_RailwayBorderPointMembers]  WITH CHECK ADD  CONSTRAINT [FK_TreeNSI_RailwayBorderPointMembers_TreeNSI_RailwayStantion] FOREIGN KEY([IdRailwayStantion])
REFERENCES [dbo].[TreeNSI_RailwayStantion] ([IdRailwayStantion])
GO

ALTER TABLE [dbo].[TreeNSI_RailwayBorderPointMembers] CHECK CONSTRAINT [FK_TreeNSI_RailwayBorderPointMembers_TreeNSI_RailwayStantion]
GO

print 'Создание CONSTRAINT FK_dbo.TreeNSI_EAEUCommonCustomsTariff_dbo.TreeNSI_EAEUCommonCustomsTariff_ParentId'
ALTER TABLE [dbo].[TreeNSI_EAEUCommonCustomsTariff]  WITH CHECK ADD  CONSTRAINT [FK_dbo.TreeNSI_EAEUCommonCustomsTariff_dbo.TreeNSI_EAEUCommonCustomsTariff_ParentId] FOREIGN KEY([ParentId])
REFERENCES [dbo].[TreeNSI_EAEUCommonCustomsTariff] ([IdCommonCustomsTariff])
GO

ALTER TABLE [dbo].[TreeNSI_EAEUCommonCustomsTariff] CHECK CONSTRAINT [FK_dbo.TreeNSI_EAEUCommonCustomsTariff_dbo.TreeNSI_EAEUCommonCustomsTariff_ParentId]
GO

print 'Создание CONSTRAINT FK_dbo.TreeNSI_EconomicActivityProductsClassificationType_dbo.TreeNSI_EconomicActivityProductsClassificationType_ParentId'
ALTER TABLE [dbo].[TreeNSI_EconomicActivityProductsClassificationType]  WITH CHECK ADD  CONSTRAINT [FK_dbo.TreeNSI_EconomicActivityProductsClassificationType_dbo.TreeNSI_EconomicActivityProductsClassificationType_ParentId] FOREIGN KEY([ParentId])
REFERENCES [dbo].[TreeNSI_EconomicActivityProductsClassificationType] ([IdClassType])
GO

ALTER TABLE [dbo].[TreeNSI_EconomicActivityProductsClassificationType] CHECK CONSTRAINT [FK_dbo.TreeNSI_EconomicActivityProductsClassificationType_dbo.TreeNSI_EconomicActivityProductsClassificationType_ParentId]
GO

print 'Создание CONSTRAINT FK_dbo.TreeNSI_EconomicActivityProductsClassification_dbo.TreeNSI_EconomicActivityProductsClassification_ParentId'
ALTER TABLE [dbo].[TreeNSI_EconomicActivityProductsClassification]  WITH CHECK ADD  CONSTRAINT [FK_dbo.TreeNSI_EconomicActivityProductsClassification_dbo.TreeNSI_EconomicActivityProductsClassification_ParentId] FOREIGN KEY([ParentId])
REFERENCES [dbo].[TreeNSI_EconomicActivityProductsClassification] ([IdClassProduct])
GO

ALTER TABLE [dbo].[TreeNSI_EconomicActivityProductsClassification] CHECK CONSTRAINT [FK_dbo.TreeNSI_EconomicActivityProductsClassification_dbo.TreeNSI_EconomicActivityProductsClassification_ParentId]
GO

print 'Создание CONSTRAINT FK_dbo.TreeNSI_EconomicActivityProductsClassification_dbo.TreeNSI_EconomicActivityProductsClassificationType_IdClassType'
ALTER TABLE [dbo].[TreeNSI_EconomicActivityProductsClassification]  WITH CHECK ADD  CONSTRAINT [FK_dbo.TreeNSI_EconomicActivityProductsClassification_dbo.TreeNSI_EconomicActivityProductsClassificationType_IdClassType] FOREIGN KEY([IdClassType])
REFERENCES [dbo].[TreeNSI_EconomicActivityProductsClassificationType] ([IdClassType])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[TreeNSI_EconomicActivityProductsClassification] CHECK CONSTRAINT [FK_dbo.TreeNSI_EconomicActivityProductsClassification_dbo.TreeNSI_EconomicActivityProductsClassificationType_IdClassType]
GO

print 'Создание CONSTRAINT FK_dbo.TreeNSI_CargoesHarmonizedNomenclature_dbo.TreeNSI_CargoesHarmonizedNomenclature_ParentId'
ALTER TABLE [dbo].[TreeNSI_CargoesHarmonizedNomenclature]  WITH CHECK ADD  CONSTRAINT [FK_dbo.TreeNSI_CargoesHarmonizedNomenclature_dbo.TreeNSI_CargoesHarmonizedNomenclature_ParentId] FOREIGN KEY([ParentId])
REFERENCES [dbo].[TreeNSI_CargoesHarmonizedNomenclature] ([IdCargoesHarmonizedNomenclature])
GO

ALTER TABLE [dbo].[TreeNSI_CargoesHarmonizedNomenclature] CHECK CONSTRAINT [FK_dbo.TreeNSI_CargoesHarmonizedNomenclature_dbo.TreeNSI_CargoesHarmonizedNomenclature_ParentId]
GO

print 'Создание CONSTRAINT FK_dbo.TreeNSI_TransportRateClass_dbo.TreeNSI_TransportRateClass_ParentId'
ALTER TABLE [dbo].[TreeNSI_TransportRateClass]  WITH CHECK ADD  CONSTRAINT [FK_dbo.TreeNSI_TransportRateClass_dbo.TreeNSI_TransportRateClass_ParentId] FOREIGN KEY([ParentId])
REFERENCES [dbo].[TreeNSI_TransportRateClass] ([IdTransportRateClass])
GO

ALTER TABLE [dbo].[TreeNSI_TransportRateClass] CHECK CONSTRAINT [FK_dbo.TreeNSI_TransportRateClass_dbo.TreeNSI_TransportRateClass_ParentId]
GO

print 'Создание CONSTRAINT FK_TreeNSI_Addr_AddressesClassifierBY_LocalityProperty_TreeNSI_Addr_AddressesClassifierBY_Locality'
ALTER TABLE [dbo].[TreeNSI_Addr_AddressesClassifierBY_LocalityProperty]  WITH CHECK ADD  CONSTRAINT [FK_TreeNSI_Addr_AddressesClassifierBY_LocalityProperty_TreeNSI_Addr_AddressesClassifierBY_Locality] FOREIGN KEY([IdElement])
REFERENCES [dbo].[TreeNSI_Addr_AddressesClassifierBY_Locality] ([IdAddrClassifierBY_Locality])
GO

ALTER TABLE [dbo].[TreeNSI_Addr_AddressesClassifierBY_LocalityProperty] CHECK CONSTRAINT [FK_TreeNSI_Addr_AddressesClassifierBY_LocalityProperty_TreeNSI_Addr_AddressesClassifierBY_Locality]
GO

print 'Создание CONSTRAINT FK_TreeNSI_Addr_AddressesClassifierRU_LocalityProperty_TreeNSI_Addr_AddressesClassifierRU_Locality'
ALTER TABLE [dbo].[TreeNSI_Addr_AddressesClassifierRU_LocalityProperty]  WITH CHECK ADD  CONSTRAINT [FK_TreeNSI_Addr_AddressesClassifierRU_LocalityProperty_TreeNSI_Addr_AddressesClassifierRU_Locality] FOREIGN KEY([IdElement])
REFERENCES [dbo].[TreeNSI_Addr_AddressesClassifierRU_Locality] ([IdAddrClassifierRU_Locality])
GO

ALTER TABLE [dbo].[TreeNSI_Addr_AddressesClassifierRU_LocalityProperty] CHECK CONSTRAINT [FK_TreeNSI_Addr_AddressesClassifierRU_LocalityProperty_TreeNSI_Addr_AddressesClassifierRU_Locality]
GO

print 'Создание CONSTRAINT FK_TreeNSI_Addr_CountryAddressesClassifierLocality_TreeNSI_Country'
ALTER TABLE [dbo].[TreeNSI_Addr_CountryAddressesClassifierLocality]  WITH CHECK ADD  CONSTRAINT [FK_TreeNSI_Addr_CountryAddressesClassifierLocality_TreeNSI_Country] FOREIGN KEY([IdCountry])
REFERENCES [dbo].[TreeNSI_Country] ([IdCountry])
GO

ALTER TABLE [dbo].[TreeNSI_Addr_CountryAddressesClassifierLocality] CHECK CONSTRAINT [FK_TreeNSI_Addr_CountryAddressesClassifierLocality_TreeNSI_Country]
GO

print 'Создание CONSTRAINT FK_TreeNSI_Addr_AdministrativTerritorialUnit_TreeNSI_Addr_AdministrativTerritorialUnitType'
ALTER TABLE [dbo].[TreeNSI_Addr_AdministrativTerritorialUnit]  WITH CHECK ADD  CONSTRAINT [FK_TreeNSI_Addr_AdministrativTerritorialUnit_TreeNSI_Addr_AdministrativTerritorialUnitType] FOREIGN KEY([IdATUType])
REFERENCES [dbo].[TreeNSI_Addr_AdministrativTerritorialUnitType] ([IdATUType])
GO

ALTER TABLE [dbo].[TreeNSI_Addr_AdministrativTerritorialUnit] CHECK CONSTRAINT [FK_TreeNSI_Addr_AdministrativTerritorialUnit_TreeNSI_Addr_AdministrativTerritorialUnitType]
GO

print 'Создание CONSTRAINT FK_TreeNSI_Addr_AdministrativTerritorialUnit_TreeNSI_Country'
ALTER TABLE [dbo].[TreeNSI_Addr_AdministrativTerritorialUnit]  WITH CHECK ADD  CONSTRAINT [FK_TreeNSI_Addr_AdministrativTerritorialUnit_TreeNSI_Country] FOREIGN KEY([IdCountry])
REFERENCES [dbo].[TreeNSI_Country] ([IdCountry])
GO

ALTER TABLE [dbo].[TreeNSI_Addr_AdministrativTerritorialUnit] CHECK CONSTRAINT [FK_TreeNSI_Addr_AdministrativTerritorialUnit_TreeNSI_Country]
GO

print 'Создание CONSTRAINT FK_dbo.TreeNSI_Addr_AdministrativTerritorialUnit_dbo.TreeNSI_Addr_AdministrativTerritorialUnit_ParentId'
ALTER TABLE [dbo].[TreeNSI_Addr_AdministrativTerritorialUnit]  WITH CHECK ADD  CONSTRAINT [FK_dbo.TreeNSI_Addr_AdministrativTerritorialUnit_dbo.TreeNSI_Addr_AdministrativTerritorialUnit_ParentId] FOREIGN KEY([ParentId])
REFERENCES [dbo].[TreeNSI_Addr_AdministrativTerritorialUnit] ([IdATU])
GO

ALTER TABLE [dbo].[TreeNSI_Addr_AdministrativTerritorialUnit] CHECK CONSTRAINT [FK_dbo.TreeNSI_Addr_AdministrativTerritorialUnit_dbo.TreeNSI_Addr_AdministrativTerritorialUnit_ParentId]
GO

print 'Создание CONSTRAINT FK_TreeNSI_Addr_ATUTypeNationalData_TreeNSI_Addr_AdministrativTerritorialUnitType'
ALTER TABLE [dbo].[TreeNSI_Addr_ATUTypeNationalData]  WITH CHECK ADD  CONSTRAINT [FK_TreeNSI_Addr_ATUTypeNationalData_TreeNSI_Addr_AdministrativTerritorialUnitType] FOREIGN KEY([IdATUType])
REFERENCES [dbo].[TreeNSI_Addr_AdministrativTerritorialUnitType] ([IdATUType])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[TreeNSI_Addr_ATUTypeNationalData] CHECK CONSTRAINT [FK_TreeNSI_Addr_ATUTypeNationalData_TreeNSI_Addr_AdministrativTerritorialUnitType]
GO

print 'Создание CONSTRAINT FK_TreeNSI_Addr_ATUTypeNationalData_TreeNSI_NationalLanguage'
ALTER TABLE [dbo].[TreeNSI_Addr_ATUTypeNationalData]  WITH CHECK ADD  CONSTRAINT [FK_TreeNSI_Addr_ATUTypeNationalData_TreeNSI_NationalLanguage] FOREIGN KEY([IdLanguage])
REFERENCES [dbo].[TreeNSI_NationalLanguage] ([IdLanguage])
GO

ALTER TABLE [dbo].[TreeNSI_Addr_ATUTypeNationalData] CHECK CONSTRAINT [FK_TreeNSI_Addr_ATUTypeNationalData_TreeNSI_NationalLanguage]
GO

print 'Создание CONSTRAINT FK_TreeNSI_Addr_ATUNationalData_TreeNSI_Addr_AdministrativTerritorialUnit'
ALTER TABLE [dbo].[TreeNSI_Addr_ATUNationalData]  WITH CHECK ADD  CONSTRAINT [FK_TreeNSI_Addr_ATUNationalData_TreeNSI_Addr_AdministrativTerritorialUnit] FOREIGN KEY([IdATU])
REFERENCES [dbo].[TreeNSI_Addr_AdministrativTerritorialUnit] ([IdATU])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[TreeNSI_Addr_ATUNationalData] CHECK CONSTRAINT [FK_TreeNSI_Addr_ATUNationalData_TreeNSI_Addr_AdministrativTerritorialUnit]
GO

print 'Создание CONSTRAINT FK_TreeNSI_Addr_ATUNationalData_TreeNSI_NationalLanguage'
ALTER TABLE [dbo].[TreeNSI_Addr_ATUNationalData]  WITH CHECK ADD  CONSTRAINT [FK_TreeNSI_Addr_ATUNationalData_TreeNSI_NationalLanguage] FOREIGN KEY([IdLanguage])
REFERENCES [dbo].[TreeNSI_NationalLanguage] ([IdLanguage])
GO

ALTER TABLE [dbo].[TreeNSI_Addr_ATUNationalData] CHECK CONSTRAINT [FK_TreeNSI_Addr_ATUNationalData_TreeNSI_NationalLanguage]
GO

print 'Создание CONSTRAINT FK_TreeNSI_Addr_Address_TreeNSI_Addr_AdministrativTerritorialUnit'
ALTER TABLE [dbo].[TreeNSI_Addr_Address]  WITH CHECK ADD  CONSTRAINT [FK_TreeNSI_Addr_Address_TreeNSI_Addr_AdministrativTerritorialUnit] FOREIGN KEY([IdATU])
REFERENCES [dbo].[TreeNSI_Addr_AdministrativTerritorialUnit] ([IdATU])
GO

ALTER TABLE [dbo].[TreeNSI_Addr_Address] CHECK CONSTRAINT [FK_TreeNSI_Addr_Address_TreeNSI_Addr_AdministrativTerritorialUnit]
GO

print 'Создание CONSTRAINT FK_TreeNSI_Addr_Address_TreeNSI_Country'
ALTER TABLE [dbo].[TreeNSI_Addr_Address]  WITH CHECK ADD  CONSTRAINT [FK_TreeNSI_Addr_Address_TreeNSI_Country] FOREIGN KEY([IdCountry])
REFERENCES [dbo].[TreeNSI_Country] ([IdCountry])
GO

ALTER TABLE [dbo].[TreeNSI_Addr_Address] CHECK CONSTRAINT [FK_TreeNSI_Addr_Address_TreeNSI_Country]
GO

print 'Создание CONSTRAINT FK_dbo.TreeNSI_Addr_AddressNationalData_dbo.TreeNSI_Addr_Address_IdAddress'
ALTER TABLE [dbo].[TreeNSI_Addr_AddressNationalData]  WITH CHECK ADD  CONSTRAINT [FK_dbo.TreeNSI_Addr_AddressNationalData_dbo.TreeNSI_Addr_Address_IdAddress] FOREIGN KEY([IdAddress])
REFERENCES [dbo].[TreeNSI_Addr_Address] ([IdAddress])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[TreeNSI_Addr_AddressNationalData] CHECK CONSTRAINT [FK_dbo.TreeNSI_Addr_AddressNationalData_dbo.TreeNSI_Addr_Address_IdAddress]
GO

print 'Создание CONSTRAINT FK_dbo.TreeNSI_Addr_AddressNationalData_dbo.TreeNSI_NationalLanguage_IdLanguage'
ALTER TABLE [dbo].[TreeNSI_Addr_AddressNationalData]  WITH CHECK ADD  CONSTRAINT [FK_dbo.TreeNSI_Addr_AddressNationalData_dbo.TreeNSI_NationalLanguage_IdLanguage] FOREIGN KEY([IdLanguage])
REFERENCES [dbo].[TreeNSI_NationalLanguage] ([IdLanguage])
GO

ALTER TABLE [dbo].[TreeNSI_Addr_AddressNationalData] CHECK CONSTRAINT [FK_dbo.TreeNSI_Addr_AddressNationalData_dbo.TreeNSI_NationalLanguage_IdLanguage]
GO

print 'Создание CONSTRAINT FK_TreeNSI_Addr_CountryAddressSettings_TreeNSI_Addr_AddressType'
ALTER TABLE [dbo].[TreeNSI_Addr_CountryAddressSettings]  WITH CHECK ADD  CONSTRAINT [FK_TreeNSI_Addr_CountryAddressSettings_TreeNSI_Addr_AddressType] FOREIGN KEY([IdAddressType])
REFERENCES [dbo].[TreeNSI_Addr_AddressType] ([IdAddressType])
GO

ALTER TABLE [dbo].[TreeNSI_Addr_CountryAddressSettings] CHECK CONSTRAINT [FK_TreeNSI_Addr_CountryAddressSettings_TreeNSI_Addr_AddressType]
GO

print 'Создание CONSTRAINT FK_TreeNSI_Addr_CountryAddressSettings_TreeNSI_Country'
ALTER TABLE [dbo].[TreeNSI_Addr_CountryAddressSettings]  WITH CHECK ADD  CONSTRAINT [FK_TreeNSI_Addr_CountryAddressSettings_TreeNSI_Country] FOREIGN KEY([IdCountry])
REFERENCES [dbo].[TreeNSI_Country] ([IdCountry])
GO

ALTER TABLE [dbo].[TreeNSI_Addr_CountryAddressSettings] CHECK CONSTRAINT [FK_TreeNSI_Addr_CountryAddressSettings_TreeNSI_Country]
GO

print 'Создание CONSTRAINT FK_TreeNSI_Addr_CountryAddressSettings_TreeNSI_NationalLanguage'
ALTER TABLE [dbo].[TreeNSI_Addr_CountryAddressSettings]  WITH CHECK ADD  CONSTRAINT [FK_TreeNSI_Addr_CountryAddressSettings_TreeNSI_NationalLanguage] FOREIGN KEY([IdLanguage])
REFERENCES [dbo].[TreeNSI_NationalLanguage] ([IdLanguage])
GO

ALTER TABLE [dbo].[TreeNSI_Addr_CountryAddressSettings] CHECK CONSTRAINT [FK_TreeNSI_Addr_CountryAddressSettings_TreeNSI_NationalLanguage]
GO

print 'Создание CONSTRAINT FK_TreeNSI_Addr_CountryAddressSettingsOrderData_TreeNSI_Addr_AdministrativTerritorialUnitType'
ALTER TABLE [dbo].[TreeNSI_Addr_CountryAddressSettingsOrderData]  WITH CHECK ADD  CONSTRAINT [FK_TreeNSI_Addr_CountryAddressSettingsOrderData_TreeNSI_Addr_AdministrativTerritorialUnitType] FOREIGN KEY([IdATUType])
REFERENCES [dbo].[TreeNSI_Addr_AdministrativTerritorialUnitType] ([IdATUType])
GO

ALTER TABLE [dbo].[TreeNSI_Addr_CountryAddressSettingsOrderData] CHECK CONSTRAINT [FK_TreeNSI_Addr_CountryAddressSettingsOrderData_TreeNSI_Addr_AdministrativTerritorialUnitType]
GO

print 'Создание CONSTRAINT FK_TreeNSI_Addr_CountryAddressSettingsOrderData_TreeNSI_Addr_CountryAddressSettings'
ALTER TABLE [dbo].[TreeNSI_Addr_CountryAddressSettingsOrderData]  WITH CHECK ADD  CONSTRAINT [FK_TreeNSI_Addr_CountryAddressSettingsOrderData_TreeNSI_Addr_CountryAddressSettings] FOREIGN KEY([IdAddressSettings])
REFERENCES [dbo].[TreeNSI_Addr_CountryAddressSettings] ([IdAddressSettings])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[TreeNSI_Addr_CountryAddressSettingsOrderData] CHECK CONSTRAINT [FK_TreeNSI_Addr_CountryAddressSettingsOrderData_TreeNSI_Addr_CountryAddressSettings]
GO

print 'Создание CONSTRAINT FK_dbo.TreeNSI_ssmUserRoles_dbo.TreeNSI_Roles_IdRole'
ALTER TABLE [dbo].[TreeNSI_ssmUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_dbo.TreeNSI_ssmUserRoles_dbo.TreeNSI_Roles_IdRole] FOREIGN KEY([IdRole])
REFERENCES [dbo].[TreeNSI_Roles] ([ID])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[TreeNSI_ssmUserRoles] CHECK CONSTRAINT [FK_dbo.TreeNSI_ssmUserRoles_dbo.TreeNSI_Roles_IdRole]
GO

print 'Создание CONSTRAINT FK_dbo.TreeNSI_ssmUserRoles_dbo.TreeNSI_Users_IdUser'
ALTER TABLE [dbo].[TreeNSI_ssmUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_dbo.TreeNSI_ssmUserRoles_dbo.TreeNSI_Users_IdUser] FOREIGN KEY([IdUser])
REFERENCES [dbo].[TreeNSI_Users] ([IdUser])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[TreeNSI_ssmUserRoles] CHECK CONSTRAINT [FK_dbo.TreeNSI_ssmUserRoles_dbo.TreeNSI_Users_IdUser]
GO

print 'Создание CONSTRAINT FK_dbo.TreeNSI_EnterpriseInformationSystemMember_dbo.TreeNSI_DirectoryType_IdDirectoryType'
ALTER TABLE [dbo].[TreeNSI_EnterpriseInformationSystemMember]  WITH CHECK ADD  CONSTRAINT [FK_dbo.TreeNSI_EnterpriseInformationSystemMember_dbo.TreeNSI_DirectoryType_IdDirectoryType] FOREIGN KEY([IdDirectoryType])
REFERENCES [dbo].[TreeNSI_DirectoryType] ([IdDirectoryType])
GO

ALTER TABLE [dbo].[TreeNSI_EnterpriseInformationSystemMember] CHECK CONSTRAINT [FK_dbo.TreeNSI_EnterpriseInformationSystemMember_dbo.TreeNSI_DirectoryType_IdDirectoryType]
GO

print 'Создание CONSTRAINT FK_TreeNSI_DirectoryCatalog_TreeNSI_DirectoryType'
ALTER TABLE [dbo].[TreeNSI_DirectoryCatalog]  WITH CHECK ADD  CONSTRAINT [FK_TreeNSI_DirectoryCatalog_TreeNSI_DirectoryType] FOREIGN KEY([IdDirectoryType])
REFERENCES [dbo].[TreeNSI_DirectoryType] ([IdDirectoryType])
GO

ALTER TABLE [dbo].[TreeNSI_DirectoryCatalog] CHECK CONSTRAINT [FK_TreeNSI_DirectoryCatalog_TreeNSI_DirectoryType]
GO

print 'Создание CONSTRAINT FK_TreeNSI_DirectoryCatalog_TreeNSI_Users'
ALTER TABLE [dbo].[TreeNSI_DirectoryCatalog]  WITH CHECK ADD  CONSTRAINT [FK_TreeNSI_DirectoryCatalog_TreeNSI_Users] FOREIGN KEY([IdAuthor])
REFERENCES [dbo].[TreeNSI_Users] ([IdUser])
GO

ALTER TABLE [dbo].[TreeNSI_DirectoryCatalog] CHECK CONSTRAINT [FK_TreeNSI_DirectoryCatalog_TreeNSI_Users]
GO

print 'Создание CONSTRAINT FK_dbo.TreeNSI_Nomenclature_dbo.TreeNSI_Nomenclature_ParentId'
ALTER TABLE [dbo].[TreeNSI_Nomenclature]  WITH CHECK ADD  CONSTRAINT [FK_dbo.TreeNSI_Nomenclature_dbo.TreeNSI_Nomenclature_ParentId] FOREIGN KEY([ParentId])
REFERENCES [dbo].[TreeNSI_Nomenclature] ([IdNomenclature])
GO

ALTER TABLE [dbo].[TreeNSI_Nomenclature] CHECK CONSTRAINT [FK_dbo.TreeNSI_Nomenclature_dbo.TreeNSI_Nomenclature_ParentId]
GO

print 'Создание CONSTRAINT FK_TreeNSI_NomenclatureProperty_TreeNSI_CargoesHarmonizedNomenclature'
ALTER TABLE [dbo].[TreeNSI_NomenclatureProperty]  WITH CHECK ADD  CONSTRAINT [FK_TreeNSI_NomenclatureProperty_TreeNSI_CargoesHarmonizedNomenclature] FOREIGN KEY([IdCargoesHarmonizedNomenclature])
REFERENCES [dbo].[TreeNSI_CargoesHarmonizedNomenclature] ([IdCargoesHarmonizedNomenclature])
GO

ALTER TABLE [dbo].[TreeNSI_NomenclatureProperty] CHECK CONSTRAINT [FK_TreeNSI_NomenclatureProperty_TreeNSI_CargoesHarmonizedNomenclature]
GO

print 'Создание CONSTRAINT FK_TreeNSI_NomenclatureProperty_TreeNSI_EAEUCommonCustomsTariff'
ALTER TABLE [dbo].[TreeNSI_NomenclatureProperty]  WITH CHECK ADD  CONSTRAINT [FK_TreeNSI_NomenclatureProperty_TreeNSI_EAEUCommonCustomsTariff] FOREIGN KEY([IdCommonCustomsTariff])
REFERENCES [dbo].[TreeNSI_EAEUCommonCustomsTariff] ([IdCommonCustomsTariff])
GO

ALTER TABLE [dbo].[TreeNSI_NomenclatureProperty] CHECK CONSTRAINT [FK_TreeNSI_NomenclatureProperty_TreeNSI_EAEUCommonCustomsTariff]
GO

print 'Создание CONSTRAINT FK_TreeNSI_NomenclatureProperty_TreeNSI_EconomicActivityProductsClassification'
ALTER TABLE [dbo].[TreeNSI_NomenclatureProperty]  WITH CHECK ADD  CONSTRAINT [FK_TreeNSI_NomenclatureProperty_TreeNSI_EconomicActivityProductsClassification] FOREIGN KEY([IdClassProduct])
REFERENCES [dbo].[TreeNSI_EconomicActivityProductsClassification] ([IdClassProduct])
GO

ALTER TABLE [dbo].[TreeNSI_NomenclatureProperty] CHECK CONSTRAINT [FK_TreeNSI_NomenclatureProperty_TreeNSI_EconomicActivityProductsClassification]
GO

print 'Создание CONSTRAINT FK_TreeNSI_NomenclatureProperty_TreeNSI_Nomenclature'
ALTER TABLE [dbo].[TreeNSI_NomenclatureProperty]  WITH CHECK ADD  CONSTRAINT [FK_TreeNSI_NomenclatureProperty_TreeNSI_Nomenclature] FOREIGN KEY([IdElement])
REFERENCES [dbo].[TreeNSI_Nomenclature] ([IdNomenclature])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[TreeNSI_NomenclatureProperty] CHECK CONSTRAINT [FK_TreeNSI_NomenclatureProperty_TreeNSI_Nomenclature]
GO

print 'Создание CONSTRAINT FK_TreeNSI_NomenclatureProperty_TreeNSI_TransportRateClass'
ALTER TABLE [dbo].[TreeNSI_NomenclatureProperty]  WITH CHECK ADD  CONSTRAINT [FK_TreeNSI_NomenclatureProperty_TreeNSI_TransportRateClass] FOREIGN KEY([IdTransportRateClass])
REFERENCES [dbo].[TreeNSI_TransportRateClass] ([IdTransportRateClass])
GO

ALTER TABLE [dbo].[TreeNSI_NomenclatureProperty] CHECK CONSTRAINT [FK_TreeNSI_NomenclatureProperty_TreeNSI_TransportRateClass]
GO

print 'Создание CONSTRAINT FK_TreeNSI_NomenclatureProductProperty_TreeNSI_MeasurementUnit'
ALTER TABLE [dbo].[TreeNSI_NomenclatureProductProperty]  WITH CHECK ADD  CONSTRAINT [FK_TreeNSI_NomenclatureProductProperty_TreeNSI_MeasurementUnit] FOREIGN KEY([MassVolumeMeashurementUnit])
REFERENCES [dbo].[TreeNSI_MeasurementUnit] ([IdMeasurementUnit])
GO

ALTER TABLE [dbo].[TreeNSI_NomenclatureProductProperty] CHECK CONSTRAINT [FK_TreeNSI_NomenclatureProductProperty_TreeNSI_MeasurementUnit]
GO

print 'Создание CONSTRAINT FK_TreeNSI_NomenclatureProductProperty_TreeNSI_Nomenclature'
ALTER TABLE [dbo].[TreeNSI_NomenclatureProductProperty]  WITH CHECK ADD  CONSTRAINT [FK_TreeNSI_NomenclatureProductProperty_TreeNSI_Nomenclature] FOREIGN KEY([IdNomenclature])
REFERENCES [dbo].[TreeNSI_Nomenclature] ([IdNomenclature])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[TreeNSI_NomenclatureProductProperty] CHECK CONSTRAINT [FK_TreeNSI_NomenclatureProductProperty_TreeNSI_Nomenclature]
GO

print 'Создание CONSTRAINT FK_TreeNSI_NomenclatureMeasurementUnit_TreeNSI_MeasurementUnit'
ALTER TABLE [dbo].[TreeNSI_NomenclatureMeasurementUnit]  WITH CHECK ADD  CONSTRAINT [FK_TreeNSI_NomenclatureMeasurementUnit_TreeNSI_MeasurementUnit] FOREIGN KEY([IdMeasurementUnit])
REFERENCES [dbo].[TreeNSI_MeasurementUnit] ([IdMeasurementUnit])
GO

ALTER TABLE [dbo].[TreeNSI_NomenclatureMeasurementUnit] CHECK CONSTRAINT [FK_TreeNSI_NomenclatureMeasurementUnit_TreeNSI_MeasurementUnit]
GO

print 'Создание CONSTRAINT FK_TreeNSI_NomenclatureMeasurementUnit_TreeNSI_Nomenclature'
ALTER TABLE [dbo].[TreeNSI_NomenclatureMeasurementUnit]  WITH CHECK ADD  CONSTRAINT [FK_TreeNSI_NomenclatureMeasurementUnit_TreeNSI_Nomenclature] FOREIGN KEY([IdNomenclature])
REFERENCES [dbo].[TreeNSI_Nomenclature] ([IdNomenclature])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[TreeNSI_NomenclatureMeasurementUnit] CHECK CONSTRAINT [FK_TreeNSI_NomenclatureMeasurementUnit_TreeNSI_Nomenclature]
GO

print 'Создание CONSTRAINT FK_TreeNSI_NomenclatureDangerousGoodProperty_TreeNSI_Nomenclature'
ALTER TABLE [dbo].[TreeNSI_NomenclatureDangerousGoodProperty]  WITH CHECK ADD  CONSTRAINT [FK_TreeNSI_NomenclatureDangerousGoodProperty_TreeNSI_Nomenclature] FOREIGN KEY([IdNomenclature])
REFERENCES [dbo].[TreeNSI_Nomenclature] ([IdNomenclature])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[TreeNSI_NomenclatureDangerousGoodProperty] CHECK CONSTRAINT [FK_TreeNSI_NomenclatureDangerousGoodProperty_TreeNSI_Nomenclature]
GO

print 'Создание CONSTRAINT FK_TreeNSI_NomenclatureDangerousGoodProperty_TreeNSI_RailwayDangerousGoodsRegulation'
ALTER TABLE [dbo].[TreeNSI_NomenclatureDangerousGoodProperty]  WITH CHECK ADD  CONSTRAINT [FK_TreeNSI_NomenclatureDangerousGoodProperty_TreeNSI_RailwayDangerousGoodsRegulation] FOREIGN KEY([IdRailwayDG])
REFERENCES [dbo].[TreeNSI_RailwayDangerousGoodsRegulation] ([IdRailwayDG])
GO

ALTER TABLE [dbo].[TreeNSI_NomenclatureDangerousGoodProperty] CHECK CONSTRAINT [FK_TreeNSI_NomenclatureDangerousGoodProperty_TreeNSI_RailwayDangerousGoodsRegulation]
GO

print 'Создание CONSTRAINT FK_TreeNSI_NomenclatureDangerousGoodProperty_TreeNSI_RBRailwayDangerousGoodsRegulation'
ALTER TABLE [dbo].[TreeNSI_NomenclatureDangerousGoodProperty]  WITH CHECK ADD  CONSTRAINT [FK_TreeNSI_NomenclatureDangerousGoodProperty_TreeNSI_RBRailwayDangerousGoodsRegulation] FOREIGN KEY([IdRBRailwayDG])
REFERENCES [dbo].[TreeNSI_RBRailwayDangerousGoodsRegulation] ([IdRBRailwayDG])
GO

ALTER TABLE [dbo].[TreeNSI_NomenclatureDangerousGoodProperty] CHECK CONSTRAINT [FK_TreeNSI_NomenclatureDangerousGoodProperty_TreeNSI_RBRailwayDangerousGoodsRegulation]
GO

print 'Создание CONSTRAINT FK_TreeNSI_NomenclatureDangerousGoodProperty_TreeNSI_RoadDangerousGoodsRegulation'
ALTER TABLE [dbo].[TreeNSI_NomenclatureDangerousGoodProperty]  WITH CHECK ADD  CONSTRAINT [FK_TreeNSI_NomenclatureDangerousGoodProperty_TreeNSI_RoadDangerousGoodsRegulation] FOREIGN KEY([IdRoadDG])
REFERENCES [dbo].[TreeNSI_RoadDangerousGoodsRegulation] ([IdRoadDG])
GO

ALTER TABLE [dbo].[TreeNSI_NomenclatureDangerousGoodProperty] CHECK CONSTRAINT [FK_TreeNSI_NomenclatureDangerousGoodProperty_TreeNSI_RoadDangerousGoodsRegulation]
GO

print 'Создание CONSTRAINT FK_TreeNSI_NomenclatureNormativeDocumentProperty_TreeNSI_Nomenclature'
ALTER TABLE [dbo].[TreeNSI_NomenclatureNormativeDocumentProperty]  WITH CHECK ADD  CONSTRAINT [FK_TreeNSI_NomenclatureNormativeDocumentProperty_TreeNSI_Nomenclature] FOREIGN KEY([IdNomenclature])
REFERENCES [dbo].[TreeNSI_Nomenclature] ([IdNomenclature])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[TreeNSI_NomenclatureNormativeDocumentProperty] CHECK CONSTRAINT [FK_TreeNSI_NomenclatureNormativeDocumentProperty_TreeNSI_Nomenclature]
GO

print 'Создание CONSTRAINT FK_TreeNSI_Nomenclature_NoneclatureType_TreeNSI_Nomenclature'
ALTER TABLE [dbo].[TreeNSI_Nomenclature_NoneclatureType]  WITH CHECK ADD  CONSTRAINT [FK_TreeNSI_Nomenclature_NoneclatureType_TreeNSI_Nomenclature] FOREIGN KEY([IdNomenclature])
REFERENCES [dbo].[TreeNSI_Nomenclature] ([IdNomenclature])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[TreeNSI_Nomenclature_NoneclatureType] CHECK CONSTRAINT [FK_TreeNSI_Nomenclature_NoneclatureType_TreeNSI_Nomenclature]
GO

print 'Создание CONSTRAINT FK_TreeNSI_Nomenclature_NoneclatureType_TreeNSI_NomenclatureType'
ALTER TABLE [dbo].[TreeNSI_Nomenclature_NoneclatureType]  WITH CHECK ADD  CONSTRAINT [FK_TreeNSI_Nomenclature_NoneclatureType_TreeNSI_NomenclatureType] FOREIGN KEY([IdNomenclatureType])
REFERENCES [dbo].[TreeNSI_NomenclatureType] ([IdNomenclatureType])
GO

ALTER TABLE [dbo].[TreeNSI_Nomenclature_NoneclatureType] CHECK CONSTRAINT [FK_TreeNSI_Nomenclature_NoneclatureType_TreeNSI_NomenclatureType]
GO

print 'Создание CONSTRAINT FK_dbo.TreeNSI_Packaging_dbo.TreeNSI_Nomenclature_IdNomenclature'
ALTER TABLE [dbo].[TreeNSI_Packaging]  WITH CHECK ADD  CONSTRAINT [FK_dbo.TreeNSI_Packaging_dbo.TreeNSI_Nomenclature_IdNomenclature] FOREIGN KEY([IdNomenclature])
REFERENCES [dbo].[TreeNSI_Nomenclature] ([IdNomenclature])
GO

ALTER TABLE [dbo].[TreeNSI_Packaging] CHECK CONSTRAINT [FK_dbo.TreeNSI_Packaging_dbo.TreeNSI_Nomenclature_IdNomenclature]
GO

print 'Создание CONSTRAINT FK_TreeNSI_Packaging_Nomenclature_TreeNSI_Nomenclature'
ALTER TABLE [dbo].[TreeNSI_Packaging_Nomenclature]  WITH CHECK ADD  CONSTRAINT [FK_TreeNSI_Packaging_Nomenclature_TreeNSI_Nomenclature] FOREIGN KEY([IdNomenclature])
REFERENCES [dbo].[TreeNSI_Nomenclature] ([IdNomenclature])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[TreeNSI_Packaging_Nomenclature] CHECK CONSTRAINT [FK_TreeNSI_Packaging_Nomenclature_TreeNSI_Nomenclature]
GO

print 'Создание CONSTRAINT FK_TreeNSI_Packaging_Nomenclature_TreeNSI_Packaging'
ALTER TABLE [dbo].[TreeNSI_Packaging_Nomenclature]  WITH CHECK ADD  CONSTRAINT [FK_TreeNSI_Packaging_Nomenclature_TreeNSI_Packaging] FOREIGN KEY([IdPackaging])
REFERENCES [dbo].[TreeNSI_Packaging] ([IdPackaging])
GO

ALTER TABLE [dbo].[TreeNSI_Packaging_Nomenclature] CHECK CONSTRAINT [FK_TreeNSI_Packaging_Nomenclature_TreeNSI_Packaging]
GO

print 'Создание CONSTRAINT FK_TreeNSI_ConformityAttestationDocument_TreeNSI_ConformityAttestationDocumentType'
ALTER TABLE [dbo].[TreeNSI_ConformityAttestationDocument]  WITH CHECK ADD  CONSTRAINT [FK_TreeNSI_ConformityAttestationDocument_TreeNSI_ConformityAttestationDocumentType] FOREIGN KEY([IdCADocumentType])
REFERENCES [dbo].[TreeNSI_ConformityAttestationDocumentType] ([IdCADocumentType])
GO

ALTER TABLE [dbo].[TreeNSI_ConformityAttestationDocument] CHECK CONSTRAINT [FK_TreeNSI_ConformityAttestationDocument_TreeNSI_ConformityAttestationDocumentType]
GO

print 'Создание CONSTRAINT FK_TreeNSI_NomenclatureConformityAttestationDocumentProperty_TreeNSI_ConformityAttestationDocument'
ALTER TABLE [dbo].[TreeNSI_NomenclatureConformityAttestationDocumentProperty]  WITH CHECK ADD  CONSTRAINT [FK_TreeNSI_NomenclatureConformityAttestationDocumentProperty_TreeNSI_ConformityAttestationDocument] FOREIGN KEY([IdCADocument])
REFERENCES [dbo].[TreeNSI_ConformityAttestationDocument] ([IdCADocument])
GO

ALTER TABLE [dbo].[TreeNSI_NomenclatureConformityAttestationDocumentProperty] CHECK CONSTRAINT [FK_TreeNSI_NomenclatureConformityAttestationDocumentProperty_TreeNSI_ConformityAttestationDocument]
GO

print 'Создание CONSTRAINT FK_TreeNSI_NomenclatureConformityAttestationDocumentProperty_TreeNSI_Nomenclature'
ALTER TABLE [dbo].[TreeNSI_NomenclatureConformityAttestationDocumentProperty]  WITH CHECK ADD  CONSTRAINT [FK_TreeNSI_NomenclatureConformityAttestationDocumentProperty_TreeNSI_Nomenclature] FOREIGN KEY([IdNomenclature])
REFERENCES [dbo].[TreeNSI_Nomenclature] ([IdNomenclature])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[TreeNSI_NomenclatureConformityAttestationDocumentProperty] CHECK CONSTRAINT [FK_TreeNSI_NomenclatureConformityAttestationDocumentProperty_TreeNSI_Nomenclature]
GO

print 'Создание CONSTRAINT FK_dbo.TreeNSI_NomenclatureRecodeTable_dbo.TreeNSI_EnterpriseInformationSystemMember_IdEISMember'
ALTER TABLE [dbo].[TreeNSI_NomenclatureRecodeTable]  WITH CHECK ADD  CONSTRAINT [FK_dbo.TreeNSI_NomenclatureRecodeTable_dbo.TreeNSI_EnterpriseInformationSystemMember_IdEISMember] FOREIGN KEY([IdEISMember])
REFERENCES [dbo].[TreeNSI_EnterpriseInformationSystemMember] ([IdEISMember])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[TreeNSI_NomenclatureRecodeTable] CHECK CONSTRAINT [FK_dbo.TreeNSI_NomenclatureRecodeTable_dbo.TreeNSI_EnterpriseInformationSystemMember_IdEISMember]
GO

print 'Создание CONSTRAINT FK_dbo.TreeNSI_NomenclatureRecodeTable_dbo.TreeNSI_Nomenclature_IdNomenclature'
ALTER TABLE [dbo].[TreeNSI_NomenclatureRecodeTable]  WITH CHECK ADD  CONSTRAINT [FK_dbo.TreeNSI_NomenclatureRecodeTable_dbo.TreeNSI_Nomenclature_IdNomenclature] FOREIGN KEY([IdNomenclature])
REFERENCES [dbo].[TreeNSI_Nomenclature] ([IdNomenclature])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[TreeNSI_NomenclatureRecodeTable] CHECK CONSTRAINT [FK_dbo.TreeNSI_NomenclatureRecodeTable_dbo.TreeNSI_Nomenclature_IdNomenclature]
GO

print 'Создание CONSTRAINT FK_dbo.TreeNSI_Counteragent_dbo.TreeNSI_Counteragent_ParentId'
ALTER TABLE [dbo].[TreeNSI_Counteragent]  WITH CHECK ADD  CONSTRAINT [FK_dbo.TreeNSI_Counteragent_dbo.TreeNSI_Counteragent_ParentId] FOREIGN KEY([ParentId])
REFERENCES [dbo].[TreeNSI_Counteragent] ([IdCounteragent])
GO

ALTER TABLE [dbo].[TreeNSI_Counteragent] CHECK CONSTRAINT [FK_dbo.TreeNSI_Counteragent_dbo.TreeNSI_Counteragent_ParentId]
GO

print 'Создание CONSTRAINT FK_dbo.TreeNSI_Counteragent_dbo.TreeNSI_Country_IdCountry'
ALTER TABLE [dbo].[TreeNSI_Counteragent]  WITH CHECK ADD  CONSTRAINT [FK_dbo.TreeNSI_Counteragent_dbo.TreeNSI_Country_IdCountry] FOREIGN KEY([IdCountry])
REFERENCES [dbo].[TreeNSI_Country] ([IdCountry])
GO

ALTER TABLE [dbo].[TreeNSI_Counteragent] CHECK CONSTRAINT [FK_dbo.TreeNSI_Counteragent_dbo.TreeNSI_Country_IdCountry]
GO

print 'Создание CONSTRAINT FK_TreeNSI_CounteragentProperty_TreeNSI_Counteragent'
ALTER TABLE [dbo].[TreeNSI_CounteragentProperty]  WITH CHECK ADD  CONSTRAINT [FK_TreeNSI_CounteragentProperty_TreeNSI_Counteragent] FOREIGN KEY([IdElement])
REFERENCES [dbo].[TreeNSI_Counteragent] ([IdCounteragent])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[TreeNSI_CounteragentProperty] CHECK CONSTRAINT [FK_TreeNSI_CounteragentProperty_TreeNSI_Counteragent]
GO

print 'Создание CONSTRAINT FK_TreeNSI_CounteragentNationalData_TreeNSI_Counteragent'
ALTER TABLE [dbo].[TreeNSI_CounteragentNationalData]  WITH CHECK ADD  CONSTRAINT [FK_TreeNSI_CounteragentNationalData_TreeNSI_Counteragent] FOREIGN KEY([IdCounteragent])
REFERENCES [dbo].[TreeNSI_Counteragent] ([IdCounteragent])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[TreeNSI_CounteragentNationalData] CHECK CONSTRAINT [FK_TreeNSI_CounteragentNationalData_TreeNSI_Counteragent]
GO

print 'Создание CONSTRAINT FK_TreeNSI_CounteragentNationalData_TreeNSI_NationalLanguage'
ALTER TABLE [dbo].[TreeNSI_CounteragentNationalData]  WITH CHECK ADD  CONSTRAINT [FK_TreeNSI_CounteragentNationalData_TreeNSI_NationalLanguage] FOREIGN KEY([IdLanguage])
REFERENCES [dbo].[TreeNSI_NationalLanguage] ([IdLanguage])
GO

ALTER TABLE [dbo].[TreeNSI_CounteragentNationalData] CHECK CONSTRAINT [FK_TreeNSI_CounteragentNationalData_TreeNSI_NationalLanguage]
GO

print 'Создание CONSTRAINT FK_TreeNSI_CounteragentRegistrationNumbersType_TreeNSI_Country'
ALTER TABLE [dbo].[TreeNSI_CounteragentRegistrationNumbersType]  WITH CHECK ADD  CONSTRAINT [FK_TreeNSI_CounteragentRegistrationNumbersType_TreeNSI_Country] FOREIGN KEY([IdCountry])
REFERENCES [dbo].[TreeNSI_Country] ([IdCountry])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[TreeNSI_CounteragentRegistrationNumbersType] CHECK CONSTRAINT [FK_TreeNSI_CounteragentRegistrationNumbersType_TreeNSI_Country]
GO

print 'Создание CONSTRAINT FK_TreeNSI_CounteragentRegistrationNumber_TreeNSI_Counteragent'
ALTER TABLE [dbo].[TreeNSI_CounteragentRegistrationNumber]  WITH CHECK ADD  CONSTRAINT [FK_TreeNSI_CounteragentRegistrationNumber_TreeNSI_Counteragent] FOREIGN KEY([IdCounteragent])
REFERENCES [dbo].[TreeNSI_Counteragent] ([IdCounteragent])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[TreeNSI_CounteragentRegistrationNumber] CHECK CONSTRAINT [FK_TreeNSI_CounteragentRegistrationNumber_TreeNSI_Counteragent]
GO

print 'Создание CONSTRAINT FK_TreeNSI_CounteragentRegistrationNumber_TreeNSI_CounteragentRegistrationNumbersType'
ALTER TABLE [dbo].[TreeNSI_CounteragentRegistrationNumber]  WITH CHECK ADD  CONSTRAINT [FK_TreeNSI_CounteragentRegistrationNumber_TreeNSI_CounteragentRegistrationNumbersType] FOREIGN KEY([IdRegNumberType])
REFERENCES [dbo].[TreeNSI_CounteragentRegistrationNumbersType] ([IdRegNumberType])
GO

ALTER TABLE [dbo].[TreeNSI_CounteragentRegistrationNumber] CHECK CONSTRAINT [FK_TreeNSI_CounteragentRegistrationNumber_TreeNSI_CounteragentRegistrationNumbersType]
GO

print 'Создание CONSTRAINT FK_TreeNSI_CounteragentAddress_TreeNSI_Addr_Address'
ALTER TABLE [dbo].[TreeNSI_CounteragentAddress]  WITH CHECK ADD  CONSTRAINT [FK_TreeNSI_CounteragentAddress_TreeNSI_Addr_Address] FOREIGN KEY([IdAddress])
REFERENCES [dbo].[TreeNSI_Addr_Address] ([IdAddress])
GO

ALTER TABLE [dbo].[TreeNSI_CounteragentAddress] CHECK CONSTRAINT [FK_TreeNSI_CounteragentAddress_TreeNSI_Addr_Address]
GO

print 'Создание CONSTRAINT FK_TreeNSI_CounteragentAddress_TreeNSI_Addr_AddressType'
ALTER TABLE [dbo].[TreeNSI_CounteragentAddress]  WITH CHECK ADD  CONSTRAINT [FK_TreeNSI_CounteragentAddress_TreeNSI_Addr_AddressType] FOREIGN KEY([IdAddressType])
REFERENCES [dbo].[TreeNSI_Addr_AddressType] ([IdAddressType])
GO

ALTER TABLE [dbo].[TreeNSI_CounteragentAddress] CHECK CONSTRAINT [FK_TreeNSI_CounteragentAddress_TreeNSI_Addr_AddressType]
GO

print 'Создание CONSTRAINT FK_TreeNSI_CounteragentAddress_TreeNSI_Counteragent'
ALTER TABLE [dbo].[TreeNSI_CounteragentAddress]  WITH CHECK ADD  CONSTRAINT [FK_TreeNSI_CounteragentAddress_TreeNSI_Counteragent] FOREIGN KEY([IdCounteragent])
REFERENCES [dbo].[TreeNSI_Counteragent] ([IdCounteragent])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[TreeNSI_CounteragentAddress] CHECK CONSTRAINT [FK_TreeNSI_CounteragentAddress_TreeNSI_Counteragent]
GO

print 'Создание CONSTRAINT FK_TreeNSI_CounteragentAddressExtraInfo_TreeNSI_CounteragentAddress'
ALTER TABLE [dbo].[TreeNSI_CounteragentAddressExtraInfo]  WITH CHECK ADD  CONSTRAINT [FK_TreeNSI_CounteragentAddressExtraInfo_TreeNSI_CounteragentAddress] FOREIGN KEY([IdCountragentAddress])
REFERENCES [dbo].[TreeNSI_CounteragentAddress] ([IdCountragentAddress])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[TreeNSI_CounteragentAddressExtraInfo] CHECK CONSTRAINT [FK_TreeNSI_CounteragentAddressExtraInfo_TreeNSI_CounteragentAddress]
GO

print 'Создание CONSTRAINT FK_TreeNSI_CounteragentContactDetails_TreeNSI_Counteragent'
ALTER TABLE [dbo].[TreeNSI_CounteragentContactDetails]  WITH CHECK ADD  CONSTRAINT [FK_TreeNSI_CounteragentContactDetails_TreeNSI_Counteragent] FOREIGN KEY([IdCounteragent])
REFERENCES [dbo].[TreeNSI_Counteragent] ([IdCounteragent])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[TreeNSI_CounteragentContactDetails] CHECK CONSTRAINT [FK_TreeNSI_CounteragentContactDetails_TreeNSI_Counteragent]
GO

print 'Создание CONSTRAINT FK_dbo.TreeNSI_CounteragentRecodeTable_dbo.TreeNSI_Counteragent_IdCounteragent'
ALTER TABLE [dbo].[TreeNSI_CounteragentRecodeTable]  WITH CHECK ADD  CONSTRAINT [FK_dbo.TreeNSI_CounteragentRecodeTable_dbo.TreeNSI_Counteragent_IdCounteragent] FOREIGN KEY([IdCounteragent])
REFERENCES [dbo].[TreeNSI_Counteragent] ([IdCounteragent])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[TreeNSI_CounteragentRecodeTable] CHECK CONSTRAINT [FK_dbo.TreeNSI_CounteragentRecodeTable_dbo.TreeNSI_Counteragent_IdCounteragent]
GO

print 'Создание CONSTRAINT FK_dbo.TreeNSI_CounteragentRecodeTable_dbo.TreeNSI_EnterpriseInformationSystemMember_IdEISMember'
ALTER TABLE [dbo].[TreeNSI_CounteragentRecodeTable]  WITH CHECK ADD  CONSTRAINT [FK_dbo.TreeNSI_CounteragentRecodeTable_dbo.TreeNSI_EnterpriseInformationSystemMember_IdEISMember] FOREIGN KEY([IdEISMember])
REFERENCES [dbo].[TreeNSI_EnterpriseInformationSystemMember] ([IdEISMember])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[TreeNSI_CounteragentRecodeTable] CHECK CONSTRAINT [FK_dbo.TreeNSI_CounteragentRecodeTable_dbo.TreeNSI_EnterpriseInformationSystemMember_IdEISMember]
GO

print 'Создание CONSTRAINT FK_dbo.TreeNSI_Subdivision_dbo.TreeNSI_Subdivision_ParentId'
ALTER TABLE [dbo].[TreeNSI_Subdivision]  WITH CHECK ADD  CONSTRAINT [FK_dbo.TreeNSI_Subdivision_dbo.TreeNSI_Subdivision_ParentId] FOREIGN KEY([ParentId])
REFERENCES [dbo].[TreeNSI_Subdivision] ([IdSubdivision])
GO

ALTER TABLE [dbo].[TreeNSI_Subdivision] CHECK CONSTRAINT [FK_dbo.TreeNSI_Subdivision_dbo.TreeNSI_Subdivision_ParentId]
GO

print 'Создание CONSTRAINT FK_TreeNSI_SubdivisionProperty_TreeNSI_Subdivision'
ALTER TABLE [dbo].[TreeNSI_SubdivisionProperty]  WITH CHECK ADD  CONSTRAINT [FK_TreeNSI_SubdivisionProperty_TreeNSI_Subdivision] FOREIGN KEY([IdElement])
REFERENCES [dbo].[TreeNSI_Subdivision] ([IdSubdivision])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[TreeNSI_SubdivisionProperty] CHECK CONSTRAINT [FK_TreeNSI_SubdivisionProperty_TreeNSI_Subdivision]
GO

print 'Создание CONSTRAINT FK_dbo.TreeNSI_IndustrialUnit_dbo.TreeNSI_IndustrialUnit_ParentId'
ALTER TABLE [dbo].[TreeNSI_IndustrialUnit]  WITH CHECK ADD  CONSTRAINT [FK_dbo.TreeNSI_IndustrialUnit_dbo.TreeNSI_IndustrialUnit_ParentId] FOREIGN KEY([ParentId])
REFERENCES [dbo].[TreeNSI_IndustrialUnit] ([IdIndustrialUnit])
GO

ALTER TABLE [dbo].[TreeNSI_IndustrialUnit] CHECK CONSTRAINT [FK_dbo.TreeNSI_IndustrialUnit_dbo.TreeNSI_IndustrialUnit_ParentId]
GO

print 'Создание CONSTRAINT FK_TreeNSI_IndustrialUnitProperty_TreeNSI_IndustrialUnit'
ALTER TABLE [dbo].[TreeNSI_IndustrialUnitProperty]  WITH CHECK ADD  CONSTRAINT [FK_TreeNSI_IndustrialUnitProperty_TreeNSI_IndustrialUnit] FOREIGN KEY([IdElement])
REFERENCES [dbo].[TreeNSI_IndustrialUnit] ([IdIndustrialUnit])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[TreeNSI_IndustrialUnitProperty] CHECK CONSTRAINT [FK_TreeNSI_IndustrialUnitProperty_TreeNSI_IndustrialUnit]
GO

print 'Создание CONSTRAINT FK_dbo.TreeNSI_IndustrialUnitModule_dbo.TreeNSI_IndustrialUnitModule_ParentId'
ALTER TABLE [dbo].[TreeNSI_IndustrialUnitModule]  WITH CHECK ADD  CONSTRAINT [FK_dbo.TreeNSI_IndustrialUnitModule_dbo.TreeNSI_IndustrialUnitModule_ParentId] FOREIGN KEY([ParentId])
REFERENCES [dbo].[TreeNSI_IndustrialUnitModule] ([IdIndustrialUnitModule])
GO

ALTER TABLE [dbo].[TreeNSI_IndustrialUnitModule] CHECK CONSTRAINT [FK_dbo.TreeNSI_IndustrialUnitModule_dbo.TreeNSI_IndustrialUnitModule_ParentId]
GO

print 'Создание CONSTRAINT FK_TreeNSI_IndustrialUnitModuleProperty_TreeNSI_IndustrialUnitModule'
ALTER TABLE [dbo].[TreeNSI_IndustrialUnitModuleProperty]  WITH CHECK ADD  CONSTRAINT [FK_TreeNSI_IndustrialUnitModuleProperty_TreeNSI_IndustrialUnitModule] FOREIGN KEY([IdElement])
REFERENCES [dbo].[TreeNSI_IndustrialUnitModule] ([IdIndustrialUnitModule])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[TreeNSI_IndustrialUnitModuleProperty] CHECK CONSTRAINT [FK_TreeNSI_IndustrialUnitModuleProperty_TreeNSI_IndustrialUnitModule]
GO

print 'Создание CONSTRAINT FK_dbo.TreeNSI_ProcessingStep_dbo.TreeNSI_ProcessingStep_ParentId'
ALTER TABLE [dbo].[TreeNSI_ProcessingStep]  WITH CHECK ADD  CONSTRAINT [FK_dbo.TreeNSI_ProcessingStep_dbo.TreeNSI_ProcessingStep_ParentId] FOREIGN KEY([ParentId])
REFERENCES [dbo].[TreeNSI_ProcessingStep] ([IdProcessingStep])
GO

ALTER TABLE [dbo].[TreeNSI_ProcessingStep] CHECK CONSTRAINT [FK_dbo.TreeNSI_ProcessingStep_dbo.TreeNSI_ProcessingStep_ParentId]
GO

print 'Создание CONSTRAINT FK_dbo.TreeNSI_Bank_dbo.TreeNSI_Counteragent_IdCounteragent'
ALTER TABLE [dbo].[TreeNSI_Bank]  WITH CHECK ADD  CONSTRAINT [FK_dbo.TreeNSI_Bank_dbo.TreeNSI_Counteragent_IdCounteragent] FOREIGN KEY([IdCounteragent])
REFERENCES [dbo].[TreeNSI_Counteragent] ([IdCounteragent])
GO

ALTER TABLE [dbo].[TreeNSI_Bank] CHECK CONSTRAINT [FK_dbo.TreeNSI_Bank_dbo.TreeNSI_Counteragent_IdCounteragent]
GO

print 'Создание CONSTRAINT FK_dbo.TreeNSI_BankAccount_dbo.TreeNSI_Bank_IdBank'
ALTER TABLE [dbo].[TreeNSI_BankAccount]  WITH CHECK ADD  CONSTRAINT [FK_dbo.TreeNSI_BankAccount_dbo.TreeNSI_Bank_IdBank] FOREIGN KEY([IdBank])
REFERENCES [dbo].[TreeNSI_Bank] ([IdBank])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[TreeNSI_BankAccount] CHECK CONSTRAINT [FK_dbo.TreeNSI_BankAccount_dbo.TreeNSI_Bank_IdBank]
GO

print 'Создание CONSTRAINT FK_dbo.TreeNSI_BankAccount_dbo.TreeNSI_Counteragent_IdCounteragent'
ALTER TABLE [dbo].[TreeNSI_BankAccount]  WITH CHECK ADD  CONSTRAINT [FK_dbo.TreeNSI_BankAccount_dbo.TreeNSI_Counteragent_IdCounteragent] FOREIGN KEY([IdCounteragent])
REFERENCES [dbo].[TreeNSI_Counteragent] ([IdCounteragent])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[TreeNSI_BankAccount] CHECK CONSTRAINT [FK_dbo.TreeNSI_BankAccount_dbo.TreeNSI_Counteragent_IdCounteragent]
GO

print 'Создание CONSTRAINT FK_dbo.TreeNSI_BankAccount_dbo.TreeNSI_Currency_IdCurrency'
ALTER TABLE [dbo].[TreeNSI_BankAccount]  WITH CHECK ADD  CONSTRAINT [FK_dbo.TreeNSI_BankAccount_dbo.TreeNSI_Currency_IdCurrency] FOREIGN KEY([IdCurrency])
REFERENCES [dbo].[TreeNSI_Currency] ([IdCurrency])
GO

ALTER TABLE [dbo].[TreeNSI_BankAccount] CHECK CONSTRAINT [FK_dbo.TreeNSI_BankAccount_dbo.TreeNSI_Currency_IdCurrency]
GO

