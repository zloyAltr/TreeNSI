using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations.Schema;
using DevExpress.ExpressApp.DC;
using DevExpress.Persistent.Base;
using DevExpress.Persistent.Validation;
using DevExpress.ExpressApp;


namespace TreeNSI.Module.BusinessObjects
{
    [Table("TreeNSI_Addr_ATUTypeNationalData")]
    [DefaultClassOptions]
    public class AdministrativTerritorialUnitTypeNationalData
    {
        [Column(Order = 0), Key]
        [VisibleInDetailView(false), VisibleInListView(true), VisibleInLookupListView(true)]
        public Int32 IdATUType { get; set; }
        [Column(Order = 1), Key]
        [VisibleInDetailView(false), VisibleInListView(true), VisibleInLookupListView(true)]
        public Int32 IdLanguage { get; set; }
        [Required]
        [FieldSize(50)]
        [StringLength(50)]
        [RuleRequiredField(DefaultContexts.Save)]
        public String Name { get; set; }
        [FieldSize(20)]
        [StringLength(20)]
        public string Acronim { get; set; }

        [ForeignKey("IdLanguage")]
        [RuleRequiredField(DefaultContexts.Save)]
        public virtual NationalLanguage NationalLanguage { get; set; }
        [ForeignKey("IdATUType")]
        [RuleRequiredField(DefaultContexts.Save)]
        public virtual AdministrativTerritorialUnitType AdministrativTerritorialUnitType { get; set; }
    }
}
