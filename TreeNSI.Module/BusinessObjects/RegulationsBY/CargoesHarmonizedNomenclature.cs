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
    [Table("TreeNSI_CargoesHarmonizedNomenclature")]
    [DefaultClassOptions]
    public class CargoesHarmonizedNomenclature : IHCategory, IXafEntityObject, IObjectSpaceLink
    {
        [Key]
        [VisibleInDetailView(false), VisibleInListView(true), VisibleInLookupListView(true)]
        public Int32 IdCargoesHarmonizedNomenclature { get; protected set; }
        [Required]
        [RuleRequiredField(DefaultContexts.Save)]
        public bool? IsGroup { get; set; }
        public Int32? ParentId { get; set; }
        [FieldSize(8)]
        [StringLength(8)]
        public String Code { get; set; }
        [Required]
        [FieldSize(850)]
        [StringLength(850)]
        [RuleRequiredField(DefaultContexts.Save)]
        public string Name { get; set; }
        [Required]
        [RuleRequiredField(DefaultContexts.Save)]
        public bool? IsActive { get; set; }

        public CargoesHarmonizedNomenclature()
        {
            Children = new BindingList<CargoesHarmonizedNomenclature>();
        }

        #region TreeData

        [ForeignKey("ParentId")]
        public virtual CargoesHarmonizedNomenclature Parent { get; set; }

        [InverseProperty("Parent")]
        public virtual IList<CargoesHarmonizedNomenclature> Children { get; set; }

        
        IBindingList ITreeNode.Children
        {
            get { return this.Children as IBindingList; }
        }
        ITreeNode IHCategory.Parent
        {
            get { return this.Parent as IHCategory; }
            set { this.Parent = value as CargoesHarmonizedNomenclature; }
        }
        ITreeNode ITreeNode.Parent
        {
            get { return this.Parent as ITreeNode; }
        }
        #endregion

        #region IXafEntityObject
        #region initialization
        void IXafEntityObject.OnCreated()
        {
            IsActive = true;
            IsGroup = false;
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
