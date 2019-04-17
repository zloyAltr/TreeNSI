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
    [NavigationItem("ОСЖД")]
    [Table("TreeNSI_RailwayBorderPointMembers")]
    public class RailwayBorderPointMembers : IXafEntityObject
    {
        [Column(Order = 0), Key, ForeignKey("RailwayBorderPoint")]
        [Required]
        public Int32 IdRailwayBorderPoint { get; protected set; }
        [Column(Order = 1), Key, ForeignKey("RailwayStantion")]
        [Required]
        public Int32 IdRailwayStantion { get; protected set; }

        [Required]
        [RuleRequiredField(DefaultContexts.Save)]
        public bool? IsActive { get; set; }

        [RuleRequiredField(DefaultContexts.Save)]
        public virtual RailwayBorderPoint RailwayBorderPoint { get; set; }
        [RuleRequiredField(DefaultContexts.Save)]
        public virtual RailwayStantion RailwayStantion { get; set; }

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
