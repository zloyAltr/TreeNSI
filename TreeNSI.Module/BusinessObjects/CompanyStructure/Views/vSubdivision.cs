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
using DevExpress.ExpressApp;

namespace TreeNSI.Module.BusinessObjects
{
    [Table("view_TreeNSI_Subdivision")]
    [DefaultClassOptions]
    public class vSubdivision
    {
        [Key]
        [ForeignKey("Subdivision")]
        [VisibleInDetailView(false), VisibleInListView(true), VisibleInLookupListView(true)]
        public Int32 IdSubdivision { get; protected set; }
        public string FullName { get; protected set; }
        public string Name { get; protected set; }
        public string ParentFulName { get; protected set; }
        public bool? IsActive { get; protected set; }
        public bool? IsGroup { get; protected set; }
        public Int32? ParentId { get; protected set; }
        public DateTime? BeginDate { get; protected set; }
        public Int32 IdProperty { get; protected set; }
        public Int32 IdCatalog { get; protected set; }
        public virtual Subdivision Subdivision { get; set; }
    }
}
