using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations.Schema;
using DevExpress.ExpressApp.DC;
using DevExpress.Persistent.Validation;
using DevExpress.Persistent.Base.General;
using DevExpress.Persistent.Base;
using DevExpress.ExpressApp;

namespace TreeNSI.Module.BusinessObjects
{
    [Table("TreeNSI_CountryNationalData")]
    [DefaultClassOptions]
    public class CountryNationalData : IXafEntityObject, IObjectSpaceLink
    {
        [Key]
        [VisibleInDetailView(false), VisibleInListView(true), VisibleInLookupListView(true)]
        public Int32 IdCountryNationalData { get; protected set; }
        [Required]
        [Browsable(false)]
        public Int32 IdCountry { get; set; }
        [Required]
        [Browsable(false)]
        public Int32 IdLanguage { get; set; }
        [Required]
        [FieldSize(100)]
        [StringLength(100)]
        public String FullName { get; set; }
        [Required]
        [RuleRequiredField(DefaultContexts.Save)]
        public DateTime? BeginDate { get; set; }
        [Required]
        [RuleRequiredField(DefaultContexts.Save)]
        public bool? IsActive { get; set; }

        [ForeignKey("IdLanguage")]
        [RuleRequiredField(DefaultContexts.Save)]
        public virtual NationalLanguage NationalLanguage { get; set; }

        [ForeignKey("IdCountry")]
        [RuleRequiredField(DefaultContexts.Save)]
        public virtual Country Country { get; set; }

        #region IXafEntityObject
        #region initialization
        void IXafEntityObject.OnCreated()
        {
            IsActive = true;
            BeginDate = DateTime.Now.Date;

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
