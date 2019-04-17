using System;
using System.Linq;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations.Schema;
using DevExpress.ExpressApp.DC;
using DevExpress.Persistent.Validation;
using DevExpress.Persistent.Base.General;
using DevExpress.Persistent.Base;
using System.Data.Entity.ModelConfiguration;
using DevExpress.ExpressApp;
using DevExpress.Data.Filtering;

namespace TreeNSI.Module.BusinessObjects
{
    [Table("TreeNSI_IndustrialProcessesUnitOwner")]
    [DefaultClassOptions]
    public class IndustrialProcessesUnitOwner
    {
        [Key]
        [VisibleInDetailView(false), VisibleInListView(true), VisibleInLookupListView(true)]
        public Int32 IdIndustrialProcessesUnitOwner { get; protected set; }
        [VisibleInDetailView(false), VisibleInListView(true), VisibleInLookupListView(true)]
        [Required]
        public Int32 IdIndustrialProcessesUnit { get; set; }
        public Int32? IdCatalogOwner { get; set; }
        [Required]
        [RuleRequiredField(DefaultContexts.Save)]
        public DateTime? BeginDate { get; set; }

        [ForeignKey("IdIndustrialProcessesUnit")]
        [RuleRequiredField(DefaultContexts.Save)]
        public virtual vDirectoryItems Element { get; set; }
        [ForeignKey("IdCatalogOwner")]
        public virtual vDirectoryItems Owner { get; set; }

        [ForeignKey("IdIndustrialProcessesUnit")]
        public virtual vIndustrialProcessesUnit viewData { get; set; }

    }
}
