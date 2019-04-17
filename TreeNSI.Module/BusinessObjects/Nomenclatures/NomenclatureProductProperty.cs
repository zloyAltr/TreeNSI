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
    [Table("TreeNSI_NomenclatureProductProperty")]
    [DefaultClassOptions]
    public class NomenclatureProductProperty : IXafEntityObject, IObjectSpaceLink
    {
        //[Key]
        //[VisibleInDetailView(false), VisibleInListView(true), VisibleInLookupListView(true)]
        //public Int32 IdProductProperty { get; protected set; }

        //[Required]
        [Key]
        [ForeignKey("Nomenclature")]
        public Int32 IdNomenclature { get; set; }
        [FieldSize(14)]
        [StringLength(14)]
        public string GTINCode { get; set; }
        public Int32? MassVolumeMeashurementUnit { get; set; }
        public decimal? MassVolume { get; set; }

        //[ForeignKey("IdNomenclature")]
        [RuleRequiredField(DefaultContexts.Save)]
        public virtual Nomenclature Nomenclature { get; set; }

        [ForeignKey("MassVolumeMeashurementUnit")]
        public virtual MeasurementUnit MeasurementUnit { get; set; }

        [NotMapped]
        public virtual string aName
        {
            get
            {
                string _return = "<>";

                decimal _massVolume = MassVolume ?? 0;
                if (MeasurementUnit != null)
                    _return = String.Format("{0} {1}",
                        (_massVolume > 0) ? String.Format("{0}", _massVolume) : "",
                        MeasurementUnit.DomesticIdentificationCode
                        );
                if (Nomenclature != null)
                    _return = String.Format("{0} {1}", Nomenclature.Name, _return);
                return _return;

            }
        }

        #region IXafEntityObject
        #region initialization
        void IXafEntityObject.OnCreated()
        {
           
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
