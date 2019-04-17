using System;
using System.Data;
using System.Linq;
using System.Data.Entity;
using System.Data.Common;
using System.Data.Entity.Core.Objects;
using System.Data.Entity.Infrastructure;
using System.ComponentModel;
using DevExpress.ExpressApp.EF.Updating;
using DevExpress.Persistent.BaseImpl.EF;
using DevExpress.Persistent.BaseImpl.EF.PermissionPolicy;

namespace TreeNSI.Module.BusinessObjects {
	public class TreeNSIDbContext : DbContext {
		public TreeNSIDbContext(String connectionString)
			: base(connectionString) {
		}
		public TreeNSIDbContext(DbConnection connection)
			: base(connection, false) {
		}
		public TreeNSIDbContext()
			: base("name=ConnectionString") {
		}


        public DbSet<ModuleInfo> ModulesInfo { get; set; }
        public DbSet<ModelDifference> ModelDifferences { get; set; }
        public DbSet<ModelDifferenceAspect> ModelDifferenceAspects { get; set; }

        public DbSet<PermissionPolicyRole> Roles { get; set; }
        public DbSet<PermissionPolicyTypePermissionObject> TypePermissionObjects { get; set; }
        public DbSet<PermissionPolicyUser> Users { get; set; }


        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            
            modelBuilder.Entity<PermissionPolicyUser>()
                .ToTable("TreeNSI_Users")
                .HasMany(c => c.Roles)
                .WithMany(r => r.Users)
                .Map(
                m =>
                {
                    m.ToTable("TreeNSI_ssmUserRoles");
                    m.MapLeftKey("IdUser");
                    m.MapRightKey("IdRole");
                })
                ;
            modelBuilder.Entity<PermissionPolicyUser>().Property(p => p.UserName).HasColumnName("ADName");
            modelBuilder.Entity<PermissionPolicyUser>().Property(p => p.ID).HasColumnName("IdUser");

            

            modelBuilder.Entity<PermissionPolicyRole>().ToTable("TreeNSI_Roles");
            modelBuilder.Entity<PermissionPolicyRoleBase>().ToTable("TreeNSI_ssmRoleBases");
            modelBuilder.Entity<PermissionPolicyTypePermissionObject>().ToTable("TreeNSI_ssmTypePermissionObjects");
            modelBuilder.Entity<PermissionPolicyMemberPermissionsObject>().ToTable("TreeNSI_ssmMemberPermissionsObject");
            modelBuilder.Entity<PermissionPolicyNavigationPermissionObject>().ToTable("TreeNSI_ssmNavigationPermissionObject");
            modelBuilder.Entity<PermissionPolicyObjectPermissionsObject>().ToTable("TreeNSI_ssmObjectPermissionsObject");

            modelBuilder.Entity<Nomenclature>()
                .HasMany(c => c.NomenclatureType)
                .WithMany(r => r.Nomenclature)
                .Map(
                m =>
                {
                    m.ToTable("TreeNSI_Nomenclature_NoneclatureType");
                    m.MapLeftKey("IdNomenclature");
                    m.MapRightKey("IdNomenclatureType");
                }
                );

            modelBuilder.Entity<Nomenclature>()
                .HasMany(c => c.Packaging)
                .WithMany(r => r.Nomenclature)
                .Map(
                m =>
                {
                    m.ToTable("TreeNSI_Packaging_Nomenclature");
                    m.MapLeftKey("IdPackaging");
                    m.MapRightKey("IdNomenclature");
                }
                );
            modelBuilder.Entity<Nomenclature>()
                .HasOptional(s => s.ProductProperty)
                .WithRequired(ex => ex.Nomenclature);
            modelBuilder.Entity<Nomenclature>()
                .HasOptional(s => s.viewData)
                .WithRequired(ex => ex.Nomenclature);


            modelBuilder.Entity<CounteragentAddress>()
                .HasOptional(s => s.ExtraInfo)
                .WithRequired(ex => ex.CounteragentAddress);
            


            modelBuilder.Entity<NomenclatureProductProperty>()
                .Property(x => x.MassVolume).HasPrecision(9, 6);

            modelBuilder.Entity<Counteragent>()
                .HasOptional(s => s.viewData)
                .WithRequired(ex => ex.Counteragent);

            modelBuilder.Entity<IndustrialUnit>()
                .HasOptional(s => s.viewData)
                .WithRequired(ex => ex.IndustrialUnit);

            modelBuilder.Entity<IndustrialUnitModule>()
                .HasOptional(s => s.viewData)
                .WithRequired(ex => ex.IndustrialUnitModule);

            modelBuilder.Entity<Subdivision>()
                .HasOptional(s => s.viewData)
                .WithRequired(ex => ex.Subdivision);



            modelBuilder.Entity<RailwayCountry>()
                .HasOptional(s => s.viewData)
                .WithRequired(ex => ex.RailwayCountry);

            modelBuilder.Entity<Country>()
                .HasOptional(s => s.viewData)
                .WithRequired(ex => ex.Country);

            modelBuilder.Entity<Currency>()
                .HasOptional(s => s.viewData)
                .WithRequired(ex => ex.Currency);

            //******
            modelBuilder.Entity<AdministrativTerritorialUnit>()
                .HasOptional(s => s.Country)
                .WithRequired()
                .WillCascadeOnDelete(false);

            
            modelBuilder.Entity<CounteragentAddress>()
                .HasOptional(s => s.Address)
                .WithRequired()
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<CounteragentRegistrationNumbersType>()
                .HasOptional(s => s.Country)
                .WithRequired()
                .WillCascadeOnDelete(false);
            modelBuilder.Entity<BankAccount>()
                .HasOptional(s => s.Counteragent)
                .WithRequired()
                .WillCascadeOnDelete(true);
        }

        public DbSet<vEmployee> vEmployee { get; set; }
        public DbSet<User> User { get; set; }

        public DbSet<DirectoryType> DirectoryType { get; set; }
        public DbSet<EnterpriseInformationSystemMember> EnterpriseInformationSystemMember { get; set; }




        public DbSet<NationalLanguage> NationalLanguage { get; set; }
        public DbSet<MeasurementUnit> MeasurementUnit { get; set; }

        public DbSet<vMeasurementUnit> vMeasurementUnit { get; set; }
        public DbSet<CountryUnion> CountryUnion { get; set; }
        public DbSet<CountryUnionMember> CountryUnionMember { get; set; }

        public DbSet<Currency> Currency { get; set; }
        public DbSet<vCurrency> vCurrency { get; set; }
        public DbSet<CurrencyProperty> CurrencyProperty { get; set; }

        public DbSet<vNormativeDocument> vNormativeDocument { get; set; }


        public DbSet<EAEUCommonCustomsTariff> EAEUCommonCustomsTariff { get; set; }
        public DbSet<vEAEUCommonCustomsTariff> vEAEUCommonCustomsTariff { get; set; }

        public DbSet<CargoesHarmonizedNomenclature> CargoesHarmonizedNomenclature { get; set; }
        public DbSet<EconomicActivityProductsClassificationType> EconomicActivityProductsClassificationType { get; set; }
        public DbSet<EconomicActivityProductsClassification> EconomicActivityProductsClassification { get; set; }
        public DbSet<TransportRateClass> TransportRateClass { get; set; }

        public DbSet<RBRailwayDangerousGoodsRegulation> RBRailwayDangerousGoodsRegulation { get; set; }
        public DbSet<RailwayDangerousGoodsRegulation> RailwayDangerousGoodsRegulation { get; set; }
        public DbSet<RoadDangerousGoodsRegulation> RoadDangerousGoodsRegulation { get; set; }

        public DbSet<Country> Country { get; set; }
        public DbSet<vCountry> vCountry { get; set; }
        public DbSet<CountryProperty> CountryProperty { get; set; }
        public DbSet<CountryNationalData> CountryNationalData { get; set; }

        public DbSet<RailwayAdministration> RailwayAdministration { get; set; }
        public DbSet<RailwayCompany> RailwayCompany { get; set; }
        public DbSet<RailwayCompanyTranslitName> RailwayCompanyTranslitName { get; set; }
        public DbSet<RailwayCountry> RailwayCountry { get; set; }
        public DbSet<RailwayCountryProperty> RailwayCountryProperty { get; set; }
        public DbSet<vRailwayCountry> vRailwayCountry { get; set; }
        public DbSet<RailwayStantion> RailwayStantion { get; set; }
        public DbSet<vRailwayStantion> vRailwayStantion { get; set; }
        public DbSet<RailwayStantionNationalData> RailwayStantionNationalData { get; set; }
        public DbSet<RailwayStantionTranslit> RailwayStantionTranslit { get; set; }
        public DbSet<RailwayBorderPoint> RailwayBorderPoint { get; set; }
        public DbSet<RailwayBorderPointMembers> RailwayBorderPointMembers { get; set; }


        public DbSet<AddressesClassifierRU> AddressesClassifierRU { get; set; }
        public DbSet<AddressesClassifierRUProperty> AddressesClassifierRUProperty { get; set; }

        public DbSet<vAddressesClassifierRU> vAddressesClassifierRU { get; set; }
        public DbSet<AddressesClassifierBY> AddressesClassifierBY { get; set; }
        public DbSet<vAddressesClassifierBY> vAddressesClassifierBY { get; set; }
        public DbSet<AddressesClassifierBYProperty> AddressesClassifierBYProperty { get; set; }

        public DbSet<AdministrativTerritorialUnitType> AdministrativTerritorialUnitType { get; set; }
        public DbSet<AdministrativTerritorialUnitTypeNationalData> AdministrativTerritorialUnitTypeNationalData { get; set; }
        public DbSet<CountryAddressesClassifierLocality> CountryAddressesClassifierLocality { get; set; }

        public DbSet<AdministrativTerritorialUnit> AdministrativTerritorialUnit { get; set; }
        
        public DbSet<AdministrativTerritorialUnitNationalData> AdministrativTerritorialUnitNationalData { get; set; }

        public DbSet<AddressType> AddressType { get; set; }
        public DbSet<CountryAddressSettings> CountryAddressSettings { get; set; }
        public DbSet<CountryAddressSettingsOrderData> CountryAddressSettingsOrderData { get; set; }
        public DbSet<BusinessObjects.Address> Address { get; set; }
        public DbSet<AddressNationalData> AddressNationalData { get; set; }


        public DbSet<Counteragent> Counteragent { get; set; }
        public DbSet<vCounteragent> vCounteragent { get; set; }
        public DbSet<CounteragentProperty> CounteragentProperty { get; set; }
        public DbSet<CounteragentNationalData> CounteragentNationalData { get; set; }
        public DbSet<CounteragentRegistrationNumbersType> CounteragentRegistrationNumbersType { get; set; }
        public DbSet<CounteragentRegistrationNumber> CounteragentRegistrationNumber { get; set; }
        public DbSet<CounteragentAddress> CounteragentAddress { get; set; }
        public DbSet<CounteragentAddressExtraInfo> CounteragentAddressExtraInfo { get; set; }
        public DbSet<CounteragentContactDetails> CounteragentContactDetails { get; set; }

        public DbSet<Bank> Bank { get; set; }
        public DbSet<BankAccount> BankAccount { get; set; }

        public DbSet<ProcessingStep> ProcessingStep { get; set; }
        public DbSet<vSubdivision> vSubdivision { get; set; }
        public DbSet<Subdivision> Subdivision { get; set; }
        public DbSet<SubdivisionProperty> SubdivisionProperty { get; set; }
        public DbSet<vIndustrialUnit> vIndustrialUnit { get; set; }
        public DbSet<IndustrialUnit> IndustrialUnit { get; set; }
        public DbSet<IndustrialUnitProperty> IndustrialUnitProperty { get; set; }
        public DbSet<vIndustrialUnitModule> vIndustrialUnitModule { get; set; }
        public DbSet<IndustrialUnitModule> IndustrialUnitModule { get; set; }
        public DbSet<IndustrialUnitModuleProperty> IndustrialUnitModuleProperty { get; set; }
        public DbSet<vIndustrialProcessesUnit> vIndustrialProcessesUnit { get; set; }
        public DbSet<IndustrialProcessesUnitOwner> IndustrialProcessesUnitOwner { get; set; }

        public DbSet<ConformityAttestationDocumentType> ConformityAttestationDocumentType { get; set; }
        public DbSet<ConformityAttestationDocument> ConformityAttestationDocument { get; set; }

        public DbSet<NomenclatureType> NomenclatureType { get; set; }
        public DbSet<vNomenclature> vNomenclature { get; set; }
        public DbSet<Nomenclature> Nomenclature { get; set; }
        public DbSet<NomenclatureProperty> NomenclatureProperty { get; set; }
        public DbSet<NomenclatureMeasurementUnit> NomenclatureMeasurementUnit { get; set; }
        public DbSet<NomenclatureNormativeDocumentProperty> NomenclatureNormativeDocumentProperty { get; set; }
        public DbSet<NomenclatureConformityAttestationDocumentProperty> NomenclatureConformityAttestationDocumentProperty { get; set; }
        public DbSet<NomenclatureDangerousGoodProperty> NomenclatureDangerousGoodProperty { get; set; }
        public DbSet<Packaging> Packaging { get; set; }
        public DbSet<NomenclatureProductProperty> NomenclatureProductProperty { get; set; }


        public DbSet<vDirectoryItems> vDirectoryItems { get; set; }
    }
}