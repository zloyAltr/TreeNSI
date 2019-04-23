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
    [Table("TreeNSI_Currency")]
    [DefaultClassOptions]
    public class Currency : IXafEntityObject, IObjectSpaceLink
    {
        [Key, DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        [VisibleInDetailView(false), VisibleInListView(true), VisibleInLookupListView(true)]
        public Int32 IdCurrency { get; protected set; }
        [Required]
        [FieldSize(3)]
        [StringLength(3)]
        [RuleRequiredField(DefaultContexts.Save)]
        public string Code { get; set; }
        [Required]
        [FieldSize(3)]
        [StringLength(3)]
        [RuleRequiredField(DefaultContexts.Save)]
        public string AlfaCode { get; set; }
        [Required]
        [RuleRequiredField(DefaultContexts.Save)]
        public bool? IsActive { get; set; }

        #region View Data
        //[ForeignKey("IdCurrency")]
        //[NotMapped]
        public vCurrency viewData { get; set; }
        #endregion

        [InverseProperty("Element")]
        public virtual IList<CurrencyProperty> PeriodicProperty { get; set; }

        public Currency()
        {
            PeriodicProperty = new BindingList<CurrencyProperty>();
            prActualDate = DateTime.Now.Date;
        }

        #region Property data

        [NotMapped]
        public DateTime? prActualDate { get; set; }

        [NotMapped]
        public virtual string aName
        {
            get
            {
                CurrencyProperty _el = getActualPeriodicObject(prActualDate);
                return (_el != null) ? _el.Name : "";
            }
        }

        

        [NotMapped]
        public virtual DateTime? aBeginDate
        {
            get
            {
                CurrencyProperty _el = getActualPeriodicObject(prActualDate);
                return (_el != null) ? _el.BeginDate : null;
            }
        }

        [Browsable(false)]
        private CurrencyProperty actualProperty;
        [Browsable(false)]
        private DateTime? actualDate;
        private CurrencyProperty getActualPeriodicObject(DateTime? _actualDate)
        {
            if (actualProperty != null && (actualDate.HasValue) && (actualDate.Value == _actualDate.Value))
                return actualProperty;
            //actualProperty = (from t in PeriodicProperty
            //                  where t.BeginDate.Value <= _actualDate.Value
            //                  orderby t.BeginDate.Value descending
            //                  select t).FirstOrDefault<CountryProperty>();
            var _list = this.PeriodicProperty.ToList<CurrencyProperty>();
            actualProperty = _list.Where<CurrencyProperty>((x => x.BeginDate.Value <= _actualDate.Value))
                .OrderByDescending(t => t.BeginDate.Value)
                .FirstOrDefault<CurrencyProperty>();
            actualDate = _actualDate;
            return actualProperty;
        }

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
