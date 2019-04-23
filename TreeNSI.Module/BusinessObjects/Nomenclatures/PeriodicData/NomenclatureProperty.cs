using System;
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
    [Table("TreeNSI_NomenclatureProperty")]
    [DefaultClassOptions]
    public class NomenclatureProperty : IXafEntityObject, IObjectSpaceLink
    {
        [Key, DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        [VisibleInDetailView(false), VisibleInListView(true), VisibleInLookupListView(true)]
        public Int32 IdProperty { get; protected set; }

        [Required]
        [Browsable(false)]
        public Int32? IdElement { get; set; }
        [Required]
        [RuleRequiredField(DefaultContexts.Save)]
        public DateTime? BeginDate { get; set; }
        [FieldSize(300)]
        [StringLength(300)]
        public string FullName { get; set; }

        [VisibleInDetailView(false), VisibleInListView(true), VisibleInLookupListView(false)]
        public Int32? IdClassProduct { get; set; }
        [VisibleInDetailView(false), VisibleInListView(true), VisibleInLookupListView(false)]
        public Int32? IdCommonCustomsTariff { get; set; }
        [VisibleInDetailView(false), VisibleInListView(true), VisibleInLookupListView(false)]
        public Int32? IdCargoesHarmonizedNomenclature { get; set; }
        [VisibleInDetailView(false), VisibleInListView(true), VisibleInLookupListView(false)]
        public Int32? IdExciseGoodsGroup { get; set; }
        [VisibleInDetailView(false), VisibleInListView(true), VisibleInLookupListView(false)]
        public Int32? IdTransportRateClass { get; set; }


        [ForeignKey("IdElement")]
        [RuleRequiredField(DefaultContexts.Save)]
        public virtual Nomenclature Element { get; set; }

        [ForeignKey("IdClassProduct")]
        public virtual EconomicActivityProductsClassification ProductsClassification { get; set; }
        [ForeignKey("IdCommonCustomsTariff")]
        public virtual EAEUCommonCustomsTariff EAEUCommonCustomsTariff { get; set; }
        [ForeignKey("IdCargoesHarmonizedNomenclature")]
        public virtual CargoesHarmonizedNomenclature CargoesHarmonizedNomenclature { get; set; }
        [ForeignKey("IdTransportRateClass")]
        public virtual TransportRateClass TransportRateClass { get; set; }

        #region IXafEntityObject
        #region initialization
        void IXafEntityObject.OnCreated()
        {
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
