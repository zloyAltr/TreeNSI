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
    [Table("TreeNSI_Nomenclature")]
    [DefaultClassOptions]
    public class Nomenclature : IHCategory, IXafEntityObject, IObjectSpaceLink, IRegistrationObject
    {
        [Key, DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        [VisibleInDetailView(false), VisibleInListView(true), VisibleInLookupListView(true)]
        public Int32 IdNomenclature { get; protected set; }
        [VisibleInDetailView(false), VisibleInListView(true), VisibleInLookupListView(true)]
        public Int32? IdCatalog { get; protected set; }

        [Required]
        [RuleRequiredField(DefaultContexts.Save)]
        public bool? IsGroup { get; set; }
        public Int32? ParentId { get; set; }

        [FieldSize(100)]
        [StringLength(100)]
        public string Name { get; set; }
        [Required]
        [RuleRequiredField(DefaultContexts.Save)]
        public bool? IsActive { get; set; }

        [ForeignKey("ParentId")]
        public virtual Nomenclature Parent { get; set; }

        [InverseProperty("Parent")]
        public virtual IList<Nomenclature> Children { get; set; }

        #region TreeData
        IBindingList ITreeNode.Children
        {
            get { return Children as IBindingList; }
        }
        ITreeNode IHCategory.Parent
        {
            get { return Parent as IHCategory; }
            set { Parent = value as Nomenclature; }
        }
        ITreeNode ITreeNode.Parent
        {
            get { return Parent as ITreeNode; }
        }
        #endregion

        public Nomenclature()
        {
            Children = new BindingList<Nomenclature>();
            PeriodicProperty = new BindingList<NomenclatureProperty>();
            prActualDate = DateTime.Now.Date;
            DangerousGood = new BindingList<NomenclatureDangerousGoodProperty>();

            MeasurementUnit = new BindingList<NomenclatureMeasurementUnit>();
            NomenclatureType = new BindingList<NomenclatureType>();
            NormativeDocument = new BindingList<NomenclatureNormativeDocumentProperty>();
            AttestationDocument = new BindingList<NomenclatureConformityAttestationDocumentProperty>();
            Packaging = new BindingList<Packaging>();
        }

        
        public virtual NomenclatureProductProperty ProductProperty { get; set; }

        [InverseProperty("Nomenclature")]
        public virtual IList<Packaging> Packaging { get; set; }

        [InverseProperty("Nomenclature")]
        public virtual IList<NomenclatureDangerousGoodProperty> DangerousGood { get; set; }

        [InverseProperty("Nomenclature")]
        public virtual IList<NomenclatureConformityAttestationDocumentProperty> AttestationDocument { get; set; }

        [InverseProperty("Nomenclature")]
        public virtual IList<NomenclatureNormativeDocumentProperty> NormativeDocument { get; set; }

        [InverseProperty("Nomenclature")]
        public virtual IList<NomenclatureType> NomenclatureType { get; set; }

        [InverseProperty("Nomenclature")]
        public virtual IList<NomenclatureMeasurementUnit> MeasurementUnit { get; set; }

        [InverseProperty("Element")]
        public virtual IList<NomenclatureProperty> PeriodicProperty { get; set; }

        #region Property data

        [NotMapped]
        public DateTime? prActualDate { get; set; }

        [NotMapped]
        public virtual string aClassProduct
        {
            get
            {
                NomenclatureProperty _el = getActualPeriodicObject(prActualDate);
                return (_el != null) ? 
                    (_el.ProductsClassification != null) ? String.Format("{0}",_el.ProductsClassification.Code) : ""
                    : "";
            }
        }

        [NotMapped]
        public virtual string aCommonCustomsTariff
        {
            get
            {
                NomenclatureProperty _el = getActualPeriodicObject(prActualDate);
                return (_el != null) ?
                    (_el.EAEUCommonCustomsTariff != null) ? String.Format("{0}", _el.EAEUCommonCustomsTariff.Code) : ""
                    : "";
            }
        }

        [NotMapped]
        public virtual string aCargoesHarmonizedNomenclature
        {
            get
            {
                NomenclatureProperty _el = getActualPeriodicObject(prActualDate);
                return (_el != null) ?
                    (_el.CargoesHarmonizedNomenclature != null) ? String.Format("{0}", _el.CargoesHarmonizedNomenclature.Code) : ""
                    : "";
            }
        }

        [NotMapped]
        public virtual string aTransportRateClass
        {
            get
            {
                NomenclatureProperty _el = getActualPeriodicObject(prActualDate);
                return (_el != null) ?
                    (_el.TransportRateClass != null) ? String.Format("{0}", _el.TransportRateClass.Code) : ""
                    : "";
            }
        }

        [NotMapped]
        public virtual string aFullName
        {
            get
            {
                NomenclatureProperty _el = getActualPeriodicObject(prActualDate);
                return (_el != null) ? _el.FullName : "";
            }
        }


        [NotMapped]
        public virtual DateTime? aBeginDate
        {
            get
            {
                NomenclatureProperty _el = getActualPeriodicObject(prActualDate);
                return (_el != null) ? _el.BeginDate : null;
            }
        }

        [Browsable(false)]
        private NomenclatureProperty actualProperty;
        [Browsable(false)]
        private DateTime? actualDate;
        private NomenclatureProperty getActualPeriodicObject(DateTime? _actualDate)
        {
            if (actualProperty != null && (actualDate.HasValue) && (actualDate.Value == _actualDate.Value))
                return actualProperty;
            var _list = PeriodicProperty.ToList<NomenclatureProperty>();
            actualProperty = _list.Where<NomenclatureProperty>((x => x.BeginDate.Value <= _actualDate.Value))
                .OrderByDescending(t => t.BeginDate.Value)
                .FirstOrDefault<NomenclatureProperty>();
            actualDate = _actualDate;
            return actualProperty;
        }

        [NotMapped]
        public virtual string aRailwayDangerousGoods
        {
            get
            {
                NomenclatureDangerousGoodProperty _el = getActualDangerousGoodPeriodicObject(prActualDate);
                return (_el != null) ?
                    (_el.RailwayDangerousGoodsRegulation != null) ? String.Format("Код опасности ООН {0}{1}", _el.RailwayDangerousGoodsRegulation.UNCode,
                    (String.IsNullOrWhiteSpace(_el.RailwayDangerousGoodsRegulation.Class)) ? "" : String.Format(", класс опасности {0}",_el.RailwayDangerousGoodsRegulation.Class)) : ""
                    : "";
            }
        }

        [NotMapped]
        public virtual string aRBRailwayDangerousGoods
        {
            get
            {
                NomenclatureDangerousGoodProperty _el = getActualDangerousGoodPeriodicObject(prActualDate);
                return (_el != null) ?
                    (_el.RBRailwayDangerousGoodsRegulation != null) ? String.Format("Код опасности ООН {0}{1}", _el.RBRailwayDangerousGoodsRegulation.UNCode,
                    (String.IsNullOrWhiteSpace(_el.RBRailwayDangerousGoodsRegulation.HazarClass)) ? "" : String.Format(", класс опасности {0}", _el.RBRailwayDangerousGoodsRegulation.HazarClass)) : ""
                    : "";
            }
        }

        [NotMapped]
        public virtual string aRoadDangerousGoods
        {
            get
            {
                NomenclatureDangerousGoodProperty _el = getActualDangerousGoodPeriodicObject(prActualDate);
                return (_el != null) ?
                    (_el.RoadDangerousGoodsRegulation != null) ? String.Format("Код опасности ООН {0}{1}", _el.RoadDangerousGoodsRegulation.UNCode,
                    (String.IsNullOrWhiteSpace(_el.RoadDangerousGoodsRegulation.Class)) ? "" : String.Format(", класс опасности {0}", _el.RoadDangerousGoodsRegulation.Class)) : ""
                    : "";
            }
        }

        [Browsable(false)]
        private NomenclatureDangerousGoodProperty actualDangerousGoodProperty;
        private NomenclatureDangerousGoodProperty getActualDangerousGoodPeriodicObject(DateTime? _actualDate)
        {
            if (actualProperty != null && (actualDate.HasValue) && (actualDate.Value == _actualDate.Value))
                return actualDangerousGoodProperty;
            var _list = DangerousGood.ToList<NomenclatureDangerousGoodProperty>();
            actualDangerousGoodProperty = _list.Where<NomenclatureDangerousGoodProperty>((x => x.BeginDate.Value <= _actualDate.Value))
                .OrderByDescending(t => t.BeginDate.Value)
                .FirstOrDefault<NomenclatureDangerousGoodProperty>();
            
            return actualDangerousGoodProperty;
        }

        #endregion

        #region View Data
        public virtual vNomenclature viewData { get; set; }
        #endregion


        #region IXafEntityObject
        #region initialization
        void IXafEntityObject.OnCreated()
        {
            IsGroup = false;
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
            setIdCatalog();
        }

        private IObjectSpace objectSpace;
        IObjectSpace IObjectSpaceLink.ObjectSpace
        {
            get { return objectSpace; }
            set { objectSpace = value; }
        }
        #endregion IXafEntityObject

        #region IRegistrationObject
        const int ID_DIRECTORY_TYPE = 1;
        public int GetIdCatalog()
        {
            return this.IdCatalog.Value;
        }

        public int GetIdTypeDirectory()
        {
            return ID_DIRECTORY_TYPE;
        }

        public int GetId()
        {
            return this.IdNomenclature;
        }

        private void setIdCatalog()
        {
            if (objectSpace != null && !objectSpace.IsObjectToDelete(this) && !this.IdCatalog.HasValue)
            {
                this.IdCatalog = DbMethods.Registration(ID_DIRECTORY_TYPE).Value;
            }
        }
        #endregion IRegistrationObject
    }
}
