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
    [Table("TreeNSI_Addr_ATUNationalData")]
    [DefaultClassOptions]
    public class AdministrativTerritorialUnitNationalData
    {
        [Column(Order = 0), Key]
        [VisibleInDetailView(false), VisibleInListView(true), VisibleInLookupListView(true)]
        public Int32 IdATU { get; set; }
        [Column(Order = 1), Key]
        [VisibleInDetailView(false), VisibleInListView(true), VisibleInLookupListView(true)]
        public Int32 IdLanguage { get; set; }
        [Required]
        [FieldSize(100)]
        [StringLength(100)]
        [RuleRequiredField(DefaultContexts.Save)]
        public String Name { get; set; }
        

        [ForeignKey("IdLanguage")]
        [RuleRequiredField(DefaultContexts.Save)]
        public virtual NationalLanguage NationalLanguage { get; set; }
        [ForeignKey("IdATU")]
        [RuleRequiredField(DefaultContexts.Save)]
        public virtual AdministrativTerritorialUnit AdministrativTerritorialUnit { get; set; }
    }
}
