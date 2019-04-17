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
    [Table("TreeNSI_RBRailwayDangerousGoodsRegulation")]
    [DefaultClassOptions]
    public class RBRailwayDangerousGoodsRegulation : IXafEntityObject, IObjectSpaceLink
    {
        [Key]
        [VisibleInDetailView(false), VisibleInListView(true), VisibleInLookupListView(true)]
        public Int32 IdRBRailwayDG { get; protected set; }
        [Required]
        [RuleRequiredField(DefaultContexts.Save)]
        [FieldSize(4)]
        [StringLength(4)]
        public string UNCode { get; set; }
        [Required]
        [FieldSize(400)]
        [StringLength(400)]
        [RuleRequiredField(DefaultContexts.Save)]
        public string Name { get; set; }
        [FieldSize(400)]
        [StringLength(400)]
        public string Description { get; set; }
        [FieldSize(3)]
        [StringLength(3)]
        public string EmergencyCardNumber { get; set; }
        [FieldSize(20)]
        [StringLength(20)]
        public string ClassificationCode { get; set; }
        [FieldSize(10)]
        [StringLength(10)]
        public string HazarClass { get; set; }
        public int? HazarCategoryNumber { get; set; }
        [FieldSize(15)]
        [StringLength(15)]
        public string BasicDangerSingNumber { get; set; }
        [FieldSize(15)]
        [StringLength(15)]
        public string AdditionalDangerSingNumber { get; set; }
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
