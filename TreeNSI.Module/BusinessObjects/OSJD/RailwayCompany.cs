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
    [Table("TreeNSI_RailwayCompany")]
    public class RailwayCompany : IXafEntityObject
    {
        [Key]
        [VisibleInDetailView(false), VisibleInListView(true), VisibleInLookupListView(true)]
        public Int32 IdRailwayCompany { get; protected set; }

        [Required]
        [RuleRequiredField(DefaultContexts.Save)]
        public Int32? IdCountry { get; set; }

        [FieldSize(4)]
        [StringLength(4)]
        public string CodeRICS { get; set; }
        [FieldSize(50)]
        [StringLength(50)]
        public String ShortName { get; set; }
        [FieldSize(250)]
        [StringLength(250)]
        public String FullName { get; set; }
        [Required]
        [RuleRequiredField(DefaultContexts.Save)]
        public bool? IsRWAdministation { get; set; }
        [Required]
        [RuleRequiredField(DefaultContexts.Save)]
        public bool? IsActive { get; set; }

        [ForeignKey("IdCountry")]
        [RuleRequiredField(DefaultContexts.Save)]
        public virtual Country Country { get; set; }

        //[ForeignKey("IdRailwayCompany")]
        public virtual RailwayCompanyTranslitName TranslitName { get; set; }

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

        
        #endregion IXafEntityObject
    }
}
