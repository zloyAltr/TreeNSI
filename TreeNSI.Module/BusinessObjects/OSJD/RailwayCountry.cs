using System;
using System.Linq;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations.Schema;
using DevExpress.ExpressApp;
using DevExpress.ExpressApp.DC;
using DevExpress.Persistent.Base;
using DevExpress.Persistent.Validation;
using DevExpress.Data.Filtering;

namespace TreeNSI.Module.BusinessObjects
{
    [NavigationItem("ОСЖД")]
    [Table("TreeNSI_RailwayCountry")]
    public class RailwayCountry : IXafEntityObject, IObjectSpaceLink
    {
        [Key]
        //[DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        [VisibleInDetailView(false), VisibleInListView(true), VisibleInLookupListView(true)]
        public Int32 IdRailwayCountry { get; protected set; }
        [FieldSize(1)]
        [Required]
        [RuleRequiredField(DefaultContexts.Save)]
        public Continent ContinentCode { get; set; } //1 Европа-Азия 2 Африка 3 Америка 4 Австралия
        [FieldSize(2)]
        [StringLength(2)]
        [Required]
        [RuleRequiredField(DefaultContexts.Save)]
        public string Code { get; set; }
        [Required]
        [RuleRequiredField(DefaultContexts.Save)]
        public Int32? IdCountry { get; set; }
        [Required]
        [RuleRequiredField(DefaultContexts.Save)]
        public bool? IsActive { get; set; }


        [ForeignKey("IdCountry")]
        [RuleRequiredField(DefaultContexts.Save)]
        public virtual Country Country { get; set; }
        [InverseProperty("Element")]
        public virtual IList<RailwayCountryProperty> PeriodicProperty { get; set; }

        public RailwayCountry()
        {
            PeriodicProperty = new BindingList<RailwayCountryProperty>();
            prActualDate = DateTime.Now.Date;
        }


        #region Property data

        [NotMapped]
        public DateTime? prActualDate { get; set; }

        [NotMapped]
        public virtual string aRailwayShortName
        {
            get
            {
                RailwayCountryProperty _el = getActualPeriodicObject(prActualDate);
                return (_el != null) ? _el.RailwayShortName : "";
            }
        }

        [NotMapped]
        public virtual string aRailwayFullName
        {
            get
            {
                RailwayCountryProperty _el = getActualPeriodicObject(prActualDate);
                return (_el != null) ? _el.RailwayFullName : "";
            }
        }

        [NotMapped]
        public virtual string aRailwayShortNameTranslit
        {
            get
            {
                RailwayCountryProperty _el = getActualPeriodicObject(prActualDate);
                return (_el != null) ? _el.RailwayShortNameTranslit : "";
            }
        }

        [NotMapped]
        public virtual string aRICS
        {
            get
            {
                RailwayCountryProperty _el = getActualPeriodicObject(prActualDate);
                return (_el != null) ? _el.RICS : "";
            }
        }

        [NotMapped]
        public virtual DateTime? aBeginDate
        {
            get
            {
                RailwayCountryProperty _el = getActualPeriodicObject(prActualDate);
                return (_el != null) ? _el.BeginDate : null;
            }
        }

        [Browsable(false)]
        private RailwayCountryProperty actualProperty;
        [Browsable(false)]
        private DateTime? actualDate;
        private RailwayCountryProperty getActualPeriodicObject(DateTime? _actualDate)
        {
            if (actualProperty != null && (actualDate.HasValue) && (actualDate.Value == _actualDate.Value))
                return actualProperty;
            //actualProperty = (from t in PeriodicProperty
            //                  where t.BeginDate.Value <= _actualDate.Value
            //                  orderby t.BeginDate.Value descending
            //                  select t).FirstOrDefault<RailwayCountryProperty>();
            var _list = PeriodicProperty.ToList<RailwayCountryProperty>();
            actualProperty = _list.Where<RailwayCountryProperty>((x => x.BeginDate.Value <= _actualDate.Value))
                .OrderByDescending(t => t.BeginDate.Value)
                .FirstOrDefault<RailwayCountryProperty>();
            actualDate = _actualDate;
            return actualProperty;
        }

        #endregion

        #region View Data
        //[ForeignKey("IdRailwayCountry")]
        //[NotMapped]
        public vRailwayCountry viewData { get; set; }
        #endregion

        #region IXafEntityObject
        #region initialization
        void IXafEntityObject.OnCreated()
        {
            IsActive = true;
            ContinentCode = Continent.Евразия;
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
