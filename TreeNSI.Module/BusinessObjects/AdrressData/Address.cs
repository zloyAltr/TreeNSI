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
    [Table("TreeNSI_Addr_Address")]
    [DefaultClassOptions]
    public class Address : IXafEntityObject, IObjectSpaceLink
    {
        [Key]
        [VisibleInDetailView(false), VisibleInListView(true), VisibleInLookupListView(true)]
        public Int32 IdAddress { get; protected set; }
        [Required]
        public Int32? IdCountry { get; set; }
        [Required]
        public Int32? IdATU { get; set; }
        [FieldSize(100)]
        [StringLength(100)]
        public String ATUAddress { get; set; }
        [FieldSize(20)]
        [StringLength(20)]
        public string PostCode { get; set; }
        [FieldSize(100)]
        [StringLength(100)]
        public string ExtraInfo { get; set; }
        [Required]
        [RuleRequiredField(DefaultContexts.Save)]
        public bool? IsActive { get; set; }

        [ForeignKey("IdCountry")]
        [RuleRequiredField(DefaultContexts.Save)]
        public virtual Country Country { get; set; }
        [ForeignKey("IdATU")]
        [RuleRequiredField(DefaultContexts.Save)]
        public virtual AdministrativTerritorialUnit ATU { get; set; }

        [InverseProperty("Address")]
        public virtual IList<AddressNationalData> NationalData { get; set; }

        [NotMapped]
        public virtual String aName
        {
            get
            {
                return String.Format("{0}, {1}{2}", 
                    (ATU == null) ? "" : ATU.Name.Trim(),
                    (String.IsNullOrWhiteSpace(this.ATUAddress)) ? "" : this.ATUAddress.Trim(), 
                    (String.IsNullOrWhiteSpace(this.ExtraInfo)) ? "" : 
                    String.Format(", {0}",this.ExtraInfo.Trim()));
            }
        }

        public Address()
        {
            NationalData = new BindingList<AddressNationalData>();
        }

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
