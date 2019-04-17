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
    [Table("TreeNSI_RailwayStantionNationalData")]
    public class RailwayStantionNationalData : IXafEntityObject
    {
        [Key]
        [VisibleInDetailView(false), VisibleInListView(true), VisibleInLookupListView(true)]
        public Int32 IdStantionNationalData { get; protected set; }

        [Required]
        public Int32? IdRailwayStantion { get; set; }
        [Required]
        [RuleRequiredField(DefaultContexts.Save)]
        public Int32? IdLanguage { get; set; }
        [Required]
        [FieldSize(100)]
        [StringLength(100)]
        [RuleRequiredField(DefaultContexts.Save)]
        public String Name { get; set; }
        [Required]
        public bool? IsActive { get; set; }

        [ForeignKey("IdRailwayStantion")]
        [RuleRequiredField(DefaultContexts.Save)]
        public virtual RailwayStantion RailwayStantion { get; set; }
        [ForeignKey("IdLanguage")]
        [RuleRequiredField(DefaultContexts.Save)]
        public virtual NationalLanguage NationalLanguage { get; set; }

        #region IXafEntityObject
        #region initialization
        void IXafEntityObject.OnCreated()
        {
            IsActive = true;
        }
        #endregion initialization

        void IXafEntityObject.OnLoaded()
        {
        }

        void IXafEntityObject.OnSaving()
        {

        }


        #endregion IXafEntityObject
    }
}
