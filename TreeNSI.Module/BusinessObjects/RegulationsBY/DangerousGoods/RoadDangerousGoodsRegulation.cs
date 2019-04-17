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
    [Table("TreeNSI_RoadDangerousGoodsRegulation")]
    [DefaultClassOptions]
    public class RoadDangerousGoodsRegulation : IXafEntityObject, IObjectSpaceLink
    {
        [Key]
        [VisibleInDetailView(false), VisibleInListView(true), VisibleInLookupListView(true)]
        public Int32 IdRoadDG { get; protected set; }
        [Required]
        [RuleRequiredField(DefaultContexts.Save)]
        [FieldSize(4)]
        [StringLength(4)]
        public string UNCode { get; set; }
        [Required]
        [FieldSize(500)]
        [StringLength(500)]
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
        [FieldSize(20)]
        [StringLength(20)]
        public string SpecialProvision { get; set; }
        [FieldSize(15)]
        [StringLength(15)]
        public string Restriction { get; set; }
        [FieldSize(25)]
        [StringLength(25)]
        public string PackingInstruction { get; set; }
        [FieldSize(30)]
        [StringLength(30)]
        public string PackingSpecialProvision { get; set; }
        [FieldSize(15)]
        [StringLength(15)]
        public string CommonPackingProvision { get; set; }
        [FieldSize(2)]
        [StringLength(2)]
        public string TankerTransport { get; set; }
        public int? TransportCategory { get; set; }
        [FieldSize(4)]
        [StringLength(4)]
        public string HazarIdentificationNumber { get; set; }
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
