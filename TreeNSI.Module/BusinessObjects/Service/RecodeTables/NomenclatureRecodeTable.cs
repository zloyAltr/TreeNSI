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
    [Table("TreeNSI_NomenclatureRecodeTable")]
    [DefaultClassOptions]
    public class NomenclatureRecodeTable
    {
        [Key, Column(Order = 0)]
        [Required]
        [VisibleInDetailView(false), VisibleInListView(true), VisibleInLookupListView(true)]
        public Int32 IdNomenclature { get; set; }
        [Key, Column(Order = 1)]
        [Required]
        [VisibleInDetailView(false), VisibleInListView(true), VisibleInLookupListView(true)]
        public Int32 IdEISMember { get; set; }
        [Key, Column(Order = 2)]
        [Required]
        [FieldSize(32)]
        [StringLength(32)]
        public string EISCode { get; set; }

        [ForeignKey("IdNomenclature")]
        [RuleRequiredField(DefaultContexts.Save)]
        public virtual Nomenclature Nomenclature { get; set; }
        [ForeignKey("IdEISMember")]
        [RuleRequiredField(DefaultContexts.Save)]
        public virtual EnterpriseInformationSystemMember EnterpriseInformationSystemMember { get; set; }
    }
}
