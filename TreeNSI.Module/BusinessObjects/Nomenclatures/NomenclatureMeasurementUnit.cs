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
    [Table("TreeNSI_NomenclatureMeasurementUnit")]
    [DefaultClassOptions]
    public class NomenclatureMeasurementUnit : IXafEntityObject, IObjectSpaceLink
    {
        [Key, DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        [VisibleInDetailView(false), VisibleInListView(true), VisibleInLookupListView(true)]
        public Int32 IdNomenclatureMeasurementUnit { get; protected set; }
        [Required]
        public Int32? IdNomenclature { get; set; }
        [Required]
        public Int32? IdMeasurementUnit { get; set; }
        [Required]
        [RuleRequiredField(DefaultContexts.Save)]
        public bool? IsBaseUnit { get; set; }

        [ForeignKey("IdNomenclature")]
        [RuleRequiredField(DefaultContexts.Save)]
        public virtual Nomenclature Nomenclature { get; set; }
        [ForeignKey("IdMeasurementUnit")]
        [RuleRequiredField(DefaultContexts.Save)]
        public virtual MeasurementUnit MeasurementUnit { get; set; }

        [NotMapped]
        public virtual string aName
        {
            get
            {
                return (MeasurementUnit != null) ? MeasurementUnit.DomesticIdentificationCode : "";
            }
        }

        #region IXafEntityObject
        #region initialization
        void IXafEntityObject.OnCreated()
        {
            IsBaseUnit = false;

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
