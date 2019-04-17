using System;
using System.Linq;
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
    [NavigationItem("ОСЖД")]
    [Table("TreeNSI_RailwayBorderPoint")]
    public class RailwayBorderPoint : IXafEntityObject
    {
        [Key]
        [VisibleInDetailView(false), VisibleInListView(true), VisibleInLookupListView(true)]
        public Int32 IdRailwayBorderPoint { get; protected set; }
        [FieldSize(4)]
        [StringLength(4)]
        public string Code { get; set; }
        public BorderPointType BorderPointType { get; set; }
        [Required]
        [RuleRequiredField(DefaultContexts.Save)]
        public bool? IsActive { get; set; }

        [InverseProperty("RailwayBorderPoint")]
        public virtual IList<RailwayBorderPointMembers> RailwayBorderPointMembers { get; set; }

        public RailwayBorderPoint()
        {
            RailwayBorderPointMembers = new BindingList<RailwayBorderPointMembers>();
        }

        [NotMapped]
        public virtual string vName
        {
            get
            {
                string _return = "";
                foreach (var x in RailwayBorderPointMembers)
                {
                    _return = _return + ((String.IsNullOrEmpty(_return)) ? "" : " / ") + x.RailwayStantion.Name.Trim() + " ("+x.RailwayStantion.RailwayCountry.Country.aAlfa2Code.Trim()+") ";
                }
                return _return;

            }
        }

        #region IXafEntityObject
        #region initialization
        void IXafEntityObject.OnCreated()
        {
            IsActive = true;
            BorderPointType = BorderPointType.ЖД;
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
