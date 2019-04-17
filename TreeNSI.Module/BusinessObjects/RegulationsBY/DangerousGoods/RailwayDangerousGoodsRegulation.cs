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
using DevExpress.Data.Filtering;



namespace TreeNSI.Module.BusinessObjects
{
    [Table("TreeNSI_RailwayDangerousGoodsRegulation")]
    [DefaultClassOptions]
    public class RailwayDangerousGoodsRegulation : IXafEntityObject, IObjectSpaceLink
    {
        [Key]
        [VisibleInDetailView(false), VisibleInListView(true), VisibleInLookupListView(true)]
        public Int32 IdRailwayDG { get; protected set; }
        [Required]
        [RuleRequiredField(DefaultContexts.Save)]
        [FieldSize(4)]
        [StringLength(4)]
        public string UNCode { get; set; }
        [Required]
        [FieldSize(600)]
        [StringLength(600)]
        [RuleRequiredField(DefaultContexts.Save)]
        public string Name { get; set; }
        [FieldSize(10)]
        [StringLength(10)]
        public string Class { get; set; }
        [FieldSize(15)]
        [StringLength(15)]
        public string ClassificationCode { get; set; }
        [FieldSize(3)]
        [StringLength(3)]
        public string PackingGroup { get; set; }
        [FieldSize(15)]
        [StringLength(15)]
        public string DangerSing { get; set; }
        [FieldSize(30)]
        [StringLength(30)]
        public string SpecialProvision { get; set; }
        [FieldSize(20)]
        [StringLength(20)]
        public string LimitedQuantity { get; set; }
        [FieldSize(2)]
        [StringLength(2)]
        public string ExceptedQuantity { get; set; }
        [FieldSize(25)]
        [StringLength(25)]
        public string PackingInstruction { get; set; }
        [FieldSize(30)]
        [StringLength(30)]
        public string PackingSpecialProvision { get; set; }
        [FieldSize(15)]
        [StringLength(15)]
        public string CommonPackingProvision { get; set; }
        [FieldSize(15)]
        [StringLength(15)]
        public string PortableTankInstruction { get; set; }
        [FieldSize(20)]
        [StringLength(20)]
        public string PortableTankSpecialProvision { get; set; }
        [FieldSize(30)]
        [StringLength(30)]
        public string TankWagonCode { get; set; }
        [FieldSize(60)]
        [StringLength(60)]
        public string TankWagonSpecialProvision { get; set; }
        public int? TransportCategory { get; set; }
        [FieldSize(10)]
        [StringLength(10)]
        public string CargoItemSpecialProvision { get; set; }
        [FieldSize(10)]
        [StringLength(10)]
        public string BulkCarriageSpecialProvision { get; set; }
        [FieldSize(50)]
        [StringLength(50)]
        public string CargoOperationsSpecialProvision { get; set; }
        [FieldSize(5)]
        [StringLength(5)]
        public string HazarCode { get; set; }
        [FieldSize(3)]
        [StringLength(3)]
        public string EmergencyCardNumber { get; set; }
        [FieldSize(30)]
        [StringLength(30)]
        public string MinimalCoverRate { get; set; }
        [FieldSize(10)]
        [StringLength(10)]
        public string HumpYardCondition { get; set; }
        [FieldSize(100)]
        [StringLength(100)]
        public string Description { get; set; }
        [Required]
        [RuleRequiredField(DefaultContexts.Save)]
        public bool? IsActive { get; set; }

        #region IXafEntityObject
        #region initialization
        void IXafEntityObject.OnCreated()
        {
            IsActive = true;
        }
        #endregion initialization

        void IXafEntityObject.OnLoaded()
        {
        }

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
