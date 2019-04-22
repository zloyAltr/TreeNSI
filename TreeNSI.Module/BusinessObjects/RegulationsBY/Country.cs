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
    [Table("TreeNSI_Country")]
    [DefaultClassOptions]
    public class Country : IXafEntityObject, IObjectSpaceLink
    {
        [Key]//, DatabaseGenerated(DatabaseGeneratedOption.Identity)
        [VisibleInDetailView(false), VisibleInListView(true), VisibleInLookupListView(true)]
        public Int32 IdCountry { get; protected set; }
        [Required]
        [FieldSize(3)]
        [StringLength(3)]
        [RuleRequiredField(DefaultContexts.Save)]
        public string Code { get; set; }
        [Required]
        [RuleRequiredField(DefaultContexts.Save)]
        public bool? IsActive { get; set; }

        public Country()
        {
            PeriodicProperty = new BindingList<CountryProperty>();
            NationalData = new BindingList<CountryNationalData>();
            prActualDate = DateTime.Now.Date;

        }

        

        [InverseProperty("Element")]
        public virtual IList<CountryProperty> PeriodicProperty { get; set; }
        [InverseProperty("Country")]
        public virtual IList<CountryNationalData> NationalData { get; set; }


        #region Property data

        [NotMapped]
        public DateTime? prActualDate { get; set; }

        [NotMapped]
        public virtual string aName
        {
            get
            {
                CountryProperty _el = getActualPeriodicObject(prActualDate);
                return (_el != null) ? _el.Name : "";
            }
        }

        [NotMapped]
        public virtual string aFullName
        {
            get
            {
                CountryProperty _el = getActualPeriodicObject(prActualDate);
                return (_el != null) ? _el.FullName : "";
            }
        }

        [NotMapped]
        public virtual string aAlfa2Code
        {
            get
            {
                CountryProperty _el = getActualPeriodicObject(prActualDate);
                return (_el != null) ? _el.Alfa2Code : "";
            }
        }

        [NotMapped]
        public virtual string aAlfa3Code
        {
            get
            {
                CountryProperty _el = getActualPeriodicObject(prActualDate);
                return (_el != null) ? _el.Alfa3Code : "";
            }
        }

        [NotMapped]
        public virtual bool? aIsOffshoreArea
        {
            get
            {
                CountryProperty _el = getActualPeriodicObject(prActualDate);
                return (_el != null) ? _el.IsOffshoreArea : null;
            }
        }

        [NotMapped]
        public virtual DateTime? aBeginDate
        {
            get
            {
                CountryProperty _el = getActualPeriodicObject(prActualDate);
                return (_el != null) ? _el.BeginDate : null;
            }
        }

        [Browsable(false)]
        private CountryProperty actualProperty;
        [Browsable(false)]
        private DateTime? actualDate;
        private CountryProperty getActualPeriodicObject(DateTime? _actualDate)
        {
            if (actualProperty != null && (actualDate.HasValue) && (actualDate.Value == _actualDate.Value))
                return actualProperty;
            //actualProperty = (from t in PeriodicProperty
            //                  where t.BeginDate.Value <= _actualDate.Value
            //                  orderby t.BeginDate.Value descending
            //                  select t).FirstOrDefault<CountryProperty>();
            var _list = PeriodicProperty.ToList<CountryProperty>();
            actualProperty = _list.Where<CountryProperty>((x => x.BeginDate.Value <= _actualDate.Value))
                .OrderByDescending(t => t.BeginDate.Value)
                .FirstOrDefault<CountryProperty>();
            actualDate = _actualDate;
            return actualProperty;
        }

        #endregion

        #region View Data
        //[ForeignKey("IdCountry")]
        //[NotMapped]
        public vCountry viewData { get; set; }
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
