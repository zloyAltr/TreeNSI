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
    [Table("TreeNSI_Addr_CountryAddressSettings")]
    [DefaultClassOptions]
    public class CountryAddressSettings : IXafEntityObject, IObjectSpaceLink
    {
        [Key]
        [VisibleInDetailView(false), VisibleInListView(true), VisibleInLookupListView(true)]
        public Int32 IdAddressSettings { get; protected set; }
        [Required]
        public Int32? IdCountry { get; set; }
        public Int32? IdAddressType { get; set; }
        public Int32? IdLanguage { get; set; }
        [FieldSize(10)]
        [StringLength(10)]
        public string StringFormat { get; set; }
        [Required]
        [RuleRequiredField(DefaultContexts.Save)]
        public DateTime? BeginDate { get; set; }
        [Required]
        [RuleRequiredField(DefaultContexts.Save)]
        public bool? IsActive { get; set; }

        [ForeignKey("IdCountry")]
        [RuleRequiredField(DefaultContexts.Save)]
        public virtual Country Country { get; set; }
        [ForeignKey("IdAddressType")]
        public virtual AddressType AddressType { get; set; }
        [ForeignKey("IdLanguage")]
        public virtual NationalLanguage NationalLanguage { get; set; }

        [InverseProperty("CountryAddressSettings")]
        public virtual IList<CountryAddressSettingsOrderData> OrderData { get; set; }

        public CountryAddressSettings()
        {
            OrderData = new BindingList<CountryAddressSettingsOrderData>();
        }

        [NotMapped]
        public virtual string aName
        {
            get
            {
                return String.Format("{0} {1}", 
                    (Country == null) ? "" : Country.aName,
                    (AddressType == null) ? "" : AddressType.Name);
            }
        }

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
