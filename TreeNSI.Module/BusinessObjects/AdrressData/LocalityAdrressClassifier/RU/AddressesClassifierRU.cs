using System;
using System.Linq;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations.Schema;
using DevExpress.ExpressApp.DC;
using DevExpress.Persistent.Validation;
using DevExpress.Persistent.Base.General;
using DevExpress.Persistent.Base;
using System.Data.Entity.ModelConfiguration;
using DevExpress.ExpressApp;
using DevExpress.Data.Filtering;

namespace TreeNSI.Module.BusinessObjects
{
    [Table("TreeNSI_Addr_AddressesClassifierRU_Locality")]
    [DefaultClassOptions]
    public class AddressesClassifierRU : IXafEntityObject, IObjectSpaceLink
    {
        [Key]
        [VisibleInDetailView(false), VisibleInListView(true), VisibleInLookupListView(true)]
        public Int32 IdAddrClassifierRU_Locality { get; protected set; }

        [Required]
        [RuleRequiredField(DefaultContexts.Save)]
        public bool? IsActive { get; set; }

        [FieldSize(250)]
        [StringLength(250)]
        public string Description { get; set; }

        public AddressesClassifierRU()
        {
            PeriodicProperty = new BindingList<AddressesClassifierRUProperty>();
            prActualDate = DateTime.Now.Date;
        }

        [InverseProperty("Element")]
        public virtual IList<AddressesClassifierRUProperty> PeriodicProperty { get; set; }

        #region Property data

        [NotMapped]
        public DateTime? prActualDate { get; set; }

        [NotMapped]
        public virtual string aName
        {
            get
            {
                AddressesClassifierRUProperty _el = getActualPeriodicObject(prActualDate);
                return (_el != null) ? _el.Name : "";
            }
        }

        [NotMapped]
        public virtual string aARCPSCode
        {
            get
            {
                AddressesClassifierRUProperty _el = getActualPeriodicObject(prActualDate);
                return (_el != null) ? _el.ARCPSCode : "";
            }
        }

        [NotMapped]
        public virtual string aCode
        {
            get
            {
                AddressesClassifierRUProperty _el = getActualPeriodicObject(prActualDate);
                return (_el != null) ? _el.Code : "";
            }
        }

        [NotMapped]
        public virtual string aLocalityType
        {
            get
            {
                AddressesClassifierRUProperty _el = getActualPeriodicObject(prActualDate);
                return (_el != null) ? _el.LocalityType : "";
            }
        }

        [NotMapped]
        public virtual string aPostcode
        {
            get
            {
                AddressesClassifierRUProperty _el = getActualPeriodicObject(prActualDate);
                return (_el != null) ? _el.Postcode : "";
            }
        }

        [NotMapped]
        public virtual int? aStatus
        {
            get
            {
                AddressesClassifierRUProperty _el = getActualPeriodicObject(prActualDate);
                return (_el != null) ? _el.Status : null;
            }
        }

        [NotMapped]
        public virtual int? aVersion
        {
            get
            {
                AddressesClassifierRUProperty _el = getActualPeriodicObject(prActualDate);
                return (_el != null) ? _el.Version : null;
            }
        }

        [NotMapped]
        public virtual DateTime? aBeginDate
        {
            get
            {
                AddressesClassifierRUProperty _el = getActualPeriodicObject(prActualDate);
                return (_el != null) ? _el.BeginDate : null;
            }
        }

        [Browsable(false)]
        private AddressesClassifierRUProperty actualProperty;
        [Browsable(false)]
        private DateTime? actualDate;
        private AddressesClassifierRUProperty getActualPeriodicObject(DateTime? _actualDate)
        {
            if (actualProperty != null && (actualDate.HasValue) && (actualDate.Value == _actualDate.Value))
                return actualProperty;
            var _list = PeriodicProperty.ToList<AddressesClassifierRUProperty>();
            actualProperty = _list.Where<AddressesClassifierRUProperty>((x => x.BeginDate.Value <= _actualDate.Value))
                .OrderByDescending(t => t.BeginDate.Value)
                .FirstOrDefault<AddressesClassifierRUProperty>();
            actualDate = _actualDate;
            return actualProperty;
        }

        #endregion

        #region View Data
        [ForeignKey("IdAddrClassifierRU_Locality")]
        public vAddressesClassifierRU viewData { get; set; }
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
