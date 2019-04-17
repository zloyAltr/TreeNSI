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

namespace TreeNSI.Module.BusinessObjects
{
    [Table("TreeNSI_Addr_AddressesClassifierBY_LocalityProperty")]
    [DefaultClassOptions]
    public class AddressesClassifierBYProperty : IXafEntityObject, IObjectSpaceLink
    {
        [Key]
        [VisibleInDetailView(false), VisibleInListView(true), VisibleInLookupListView(true)]
        public Int32 IdProperty { get; protected set; }

        [Required]
        [Browsable(false)]
        public Int32 IdElement { get; set; }

        [Required]
        [RuleRequiredField(DefaultContexts.Save)]
        public DateTime? BeginDate { get; set; }

        [Required]
        [FieldSize(50)]
        [StringLength(50)]
        [RuleRequiredField(DefaultContexts.Save)]
        public string Name { get; set; }
        [Required]
        [FieldSize(50)]
        [StringLength(50)]
        [RuleRequiredField(DefaultContexts.Save)]
        public string LocalityType { get; set; }
        [Required]
        [FieldSize(10)]
        [StringLength(10)]
        [RuleRequiredField(DefaultContexts.Save)]
        public string Code { get; set; }
        public DateTime? EndDate { get; set; }
        [FieldSize(3)]
        [StringLength(3)]
        public string LocalityTypeCode { get; set; }
        [FieldSize(3)]
        [StringLength(3)]
        public string DistrictCode { get; set; }
        [FieldSize(50)]
        [StringLength(50)]
        public string DistrictName { get; set; }
        [FieldSize(3)]
        [StringLength(3)]
        public string RegionCode { get; set; }
        [FieldSize(50)]
        [StringLength(50)]
        public string RegionName { get; set; }

        [ForeignKey("IdElement")]
        [RuleRequiredField(DefaultContexts.Save)]
        public virtual AddressesClassifierBY Element { get; set; }
        
        
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
