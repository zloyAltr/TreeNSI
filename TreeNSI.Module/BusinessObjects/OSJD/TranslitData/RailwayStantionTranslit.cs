using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations.Schema;
using DevExpress.ExpressApp;
using DevExpress.ExpressApp.DC;
using DevExpress.Persistent.Base;
using DevExpress.Persistent.Validation;

namespace TreeNSI.Module.BusinessObjects
{
    [NavigationItem("ОСЖД")]
    [Table("TreeNSI_RailwayStantionTranslit")]
    public class RailwayStantionTranslit
    {
        [Key]
        [ForeignKey("RailwayStantion")]
        [VisibleInDetailView(false), VisibleInListView(true), VisibleInLookupListView(true)]
        public Int32 IdRailwayStantion { get; protected set; }
        [Required]
        [FieldSize(100)]
        [StringLength(100)]
        [RuleRequiredField(DefaultContexts.Save)]
        public String NameTranslit { get; set; }
        [RuleRequiredField(DefaultContexts.Save)]
        public virtual RailwayStantion RailwayStantion { get; set; }
    }
}
