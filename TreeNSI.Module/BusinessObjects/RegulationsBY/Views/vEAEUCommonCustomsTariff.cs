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
    //[NavigationItem("Нормативные данные")]
    [Table("view_TreeNSI_EAEUCommonCustomsTariff")]
    [DefaultClassOptions]
    public class vEAEUCommonCustomsTariff
    {
        [Key]
        [VisibleInDetailView(false), VisibleInListView(true), VisibleInLookupListView(true)]
        public Int32 IdCommonCustomsTariff { get; protected set; }
        [Required]
        public bool? IsGroup { get; set; }
        public Int32? ParentId { get; set; }
        [FieldSize(15)]
        public String Code { get; set; }
        [Required]
        [FieldSize(1000)]
        public string Name { get; set; }
        [FieldSize(20)]
        public string AdditionalMeasurementUnit { get; set; }
        [FieldSize(70)]
        public string DutyRate { get; set; }
        [Required]
        public bool? IsActive { get; set; }
        public string ParentCode { get; set; }
        public string ParentName { get; set; }
    }
}
