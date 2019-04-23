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
    [Table("TreeNSI_NomenclatureDangerousGoodProperty")]
    [DefaultClassOptions]
    public class NomenclatureDangerousGoodProperty : IXafEntityObject, IObjectSpaceLink
    {
        [Key, DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        [VisibleInDetailView(false), VisibleInListView(true), VisibleInLookupListView(true)]
        public Int32 IdDangerousGoodProperty { get; protected set; }

        [Required]
        [Browsable(false)]
        public Int32? IdNomenclature { get; set; }
        [Required]
        [RuleRequiredField(DefaultContexts.Save)]
        public DateTime? BeginDate { get; set; }
        public Int32? IdRailwayDG { get; set; }
        public Int32? IdRBRailwayDG { get; set; }
        public Int32? IdRoadDG { get; set; }

        [ForeignKey("IdNomenclature")]
        [RuleRequiredField(DefaultContexts.Save)]
        public virtual Nomenclature Nomenclature { get; set; }

        [ForeignKey("IdRailwayDG")]
        public virtual RailwayDangerousGoodsRegulation RailwayDangerousGoodsRegulation { get; set; }
        [ForeignKey("IdRBRailwayDG")]
        public virtual RBRailwayDangerousGoodsRegulation RBRailwayDangerousGoodsRegulation { get; set; }
        [ForeignKey("IdRoadDG")]
        public virtual RoadDangerousGoodsRegulation RoadDangerousGoodsRegulation { get; set; }

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
