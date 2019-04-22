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


namespace TreeNSI.Module.BusinessObjects
{
    [Table("TreeNSI_Addr_AddressesClassifierBY_Locality")]
    [DefaultClassOptions]
    public class AddressesClassifierBY : IXafEntityObject, IObjectSpaceLink
    {
        [Key]
        [VisibleInDetailView(false), VisibleInListView(true), VisibleInLookupListView(true)]
        public Int32 IdAddrClassifierBY_Locality { get; protected set; }

        [Required]
        [RuleRequiredField(DefaultContexts.Save)]
        public bool? IsActive { get; set; }

        [FieldSize(250)]
        [StringLength(250)]
        public string Description { get; set; }

        public AddressesClassifierBY()
        {
            PeriodicProperty = new BindingList<AddressesClassifierBYProperty>();
            prActualDate = DateTime.Now.Date;
        }

        [InverseProperty("Element")]
        public virtual IList<AddressesClassifierBYProperty> PeriodicProperty { get; set; }

        #region Property data

        [NotMapped]
        public DateTime? prActualDate { get; set; }

        [NotMapped]
        public virtual string aName
        {
            get
            {
                AddressesClassifierBYProperty _el = getActualPeriodicObject(prActualDate);
                return (_el != null) ? _el.Name : "";
            }
        }

        [NotMapped]
        public virtual string aCode
        {
            get
            {
                AddressesClassifierBYProperty _el = getActualPeriodicObject(prActualDate);
                return (_el != null) ? _el.Code : "";
            }
        }

        [NotMapped]
        public virtual string aDistrictCode
        {
            get
            {
                AddressesClassifierBYProperty _el = getActualPeriodicObject(prActualDate);
                return (_el != null) ? _el.DistrictCode : "";
            }
        }

        [NotMapped]
        public virtual string aDistrictName
        {
            get
            {
                AddressesClassifierBYProperty _el = getActualPeriodicObject(prActualDate);
                return (_el != null) ? _el.DistrictName : "";
            }
        }

        [NotMapped]
        public virtual string aLocalityType
        {
            get
            {
                AddressesClassifierBYProperty _el = getActualPeriodicObject(prActualDate);
                return (_el != null) ? _el.LocalityType : "";
            }
        }

        [NotMapped]
        public virtual string aLocalityTypeCode
        {
            get
            {
                AddressesClassifierBYProperty _el = getActualPeriodicObject(prActualDate);
                return (_el != null) ? _el.LocalityTypeCode : "";
            }
        }

        [NotMapped]
        public virtual string aRegionCode
        {
            get
            {
                AddressesClassifierBYProperty _el = getActualPeriodicObject(prActualDate);
                return (_el != null) ? _el.RegionCode : "";
            }
        }

        [NotMapped]
        public virtual string aRegionName
        {
            get
            {
                AddressesClassifierBYProperty _el = getActualPeriodicObject(prActualDate);
                return (_el != null) ? _el.RegionName : "";
            }
        }

        [NotMapped]
        public virtual DateTime? aEndDate
        {
            get
            {
                AddressesClassifierBYProperty _el = getActualPeriodicObject(prActualDate);
                return (_el != null) ? _el.EndDate : null;
            }
        }

        [NotMapped]
        public virtual DateTime? aBeginDate
        {
            get
            {
                AddressesClassifierBYProperty _el = getActualPeriodicObject(prActualDate);
                return (_el != null) ? _el.BeginDate : null;
            }
        }

        [Browsable(false)]
        private AddressesClassifierBYProperty actualProperty;
        [Browsable(false)]
        private DateTime? actualDate;
        private AddressesClassifierBYProperty getActualPeriodicObject(DateTime? _actualDate)
        {
            if (actualProperty != null && (actualDate.HasValue) && (actualDate.Value == _actualDate.Value))
                return actualProperty;
            //actualProperty = (from t in PeriodicProperty.ToList<AddressesClassifierBYProperty>()
            //where t.BeginDate.Value <= _actualDate.Value
            //orderby t.BeginDate.Value descending
            //select t).FirstOrDefault<AddressesClassifierBYProperty>();
            var _list = PeriodicProperty.ToList<AddressesClassifierBYProperty>();
            actualProperty = _list.Where<AddressesClassifierBYProperty>((x => x.BeginDate.Value <= _actualDate.Value))
                .OrderByDescending(t => t.BeginDate.Value)
                .FirstOrDefault<AddressesClassifierBYProperty>();
            actualDate = _actualDate;
            return actualProperty;
        }

        #endregion

        #region View Data
        public vAddressesClassifierBY viewData { get; set; }
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
