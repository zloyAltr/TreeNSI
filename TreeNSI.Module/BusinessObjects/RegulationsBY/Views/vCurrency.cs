using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations.Schema;
using DevExpress.ExpressApp.DC;
using DevExpress.Persistent.Validation;
using DevExpress.Persistent.Base.General;
using DevExpress.Persistent.Base;
using System.Data.Entity.ModelConfiguration;



namespace TreeNSI.Module.BusinessObjects
{
    [Table("view_TreeNSI_Currency")]
    [DefaultClassOptions]
    public class vCurrency
    {
        [Key]
        [ForeignKey("Currency")]
        [VisibleInDetailView(false), VisibleInListView(true), VisibleInLookupListView(true)]
        public Int32 IdCurrency { get; protected set; }
        public string Code { get; protected set; }
        public string Name { get; protected set; }
        public string AlfaCode { get; protected set; }
        public bool? IsActive { get; protected set; }
        public DateTime? BeginDate { get; protected set; }
        public Int32 IdProperty { get; protected set; }
        public virtual Currency Currency { get; set; }
    }
}
