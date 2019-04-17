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
    [Table("view_TreeNSI_Employee")]
    [DefaultClassOptions]
    public class vEmployee
    {
        [Key]
        [VisibleInDetailView(false), VisibleInListView(true), VisibleInLookupListView(true)]
        [StringLength(38)]
        public string ID { get; protected set; }
        [Required()]
        [StringLength(100)]
        public string fio { get; protected set; }
        [StringLength(50)]
        public string fam { get; protected set; }
        [StringLength(50)]
        public string ima { get; protected set; }
        [StringLength(50)]
        public string otc { get; protected set; }
        public DateTime? data_r { get; protected set; }
        [StringLength(100)]
        public string dol { get; protected set; }
        
    }
}
