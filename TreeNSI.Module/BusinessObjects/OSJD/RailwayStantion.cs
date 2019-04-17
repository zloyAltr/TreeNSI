using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations.Schema;
using DevExpress.ExpressApp;
using DevExpress.ExpressApp.DC;
using DevExpress.Persistent.Base;
using DevExpress.Data.Filtering;
using DevExpress.Persistent.Validation;

namespace TreeNSI.Module.BusinessObjects
{
    [NavigationItem("ОСЖД")]
    [Table("TreeNSI_RailwayStantion")]
    public class RailwayStantion : IXafEntityObject, IObjectSpaceLink
    {
        [Key]
        [VisibleInDetailView(false), VisibleInListView(true), VisibleInLookupListView(true)]
        public Int32 IdRailwayStantion { get; protected set; }
        [Required]
        [RuleRequiredField(DefaultContexts.Save)]
        public Int32? IdRailwayCountry { get; set; }
        [FieldSize(6)]
        [StringLength(6)]
        public string Code { get; set; }
        [FieldSize(100)]
        [StringLength(100)]
        [Required]
        [RuleRequiredField(DefaultContexts.Save)]
        public String Name { get; set; }
        [FieldSize(4)]
        [StringLength(4)]
        public string BorderPointCode { get; set; }
        [Required]
        [RuleRequiredField(DefaultContexts.Save)]
        public bool? IsActive { get; set; }

        [ForeignKey("IdRailwayCountry")]
        [RuleRequiredField(DefaultContexts.Save)]
        public virtual RailwayCountry RailwayCountry { get; set; }

        [InverseProperty("RailwayStantion")]
        public virtual IList<RailwayStantionNationalData> NationalData { get; set; }
        //[InverseProperty("RailwayStantion")]
        public virtual RailwayStantionTranslit Translit { get; set; }

        public RailwayStantion()
        {
            NationalData = new BindingList<RailwayStantionNationalData>();
        }

        #region View from SQL
        //[NotMapped]
        //public virtual vRailwayStantion vList { get; set; }

        #endregion

        #region IXafEntityObject
        #region initialization
        void IXafEntityObject.OnCreated()
        {
            IsActive = true;
        }
        #endregion initialization

        #region data from view
        void IXafEntityObject.OnLoaded()
        {
            
        }
        #endregion data from view


        void IXafEntityObject.OnSaving()
        {

        }

        private IObjectSpace objectSpace;
        IObjectSpace IObjectSpaceLink.ObjectSpace
        {
            get { return objectSpace; }
            set { objectSpace = value; }
        }
        #endregion IXafEntityObject
    }
}
