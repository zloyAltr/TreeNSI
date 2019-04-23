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
    [Table("TreeNSI_EconomicActivityProductsClassification")]
    [DefaultClassOptions]
    public class EconomicActivityProductsClassification : IHCategory, IXafEntityObject, IObjectSpaceLink
    {
        [Key, DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        [VisibleInDetailView(false), VisibleInListView(true), VisibleInLookupListView(true)]
        public Int32 IdClassProduct { get; protected set; }
        [Required]
        [RuleRequiredField(DefaultContexts.Save)]
        public Int32 IdClassType { get; set; }
        [Required]
        [RuleRequiredField(DefaultContexts.Save)]
        public bool? IsGroup { get; set; }
        public Int32? ParentId { get; set; }
        [FieldSize(12)]
        [StringLength(12)]
        public String Code { get; set; }
        [Required]
        [FieldSize(550)]
        [StringLength(550)]
        [RuleRequiredField(DefaultContexts.Save)]
        public string Name { get; set; }

        public EconomicActivityProductsClassification()
        {
            Children = new BindingList<EconomicActivityProductsClassification>();
        }

        [ForeignKey("IdClassType")]
        [RuleRequiredField(DefaultContexts.Save)]
        public virtual EconomicActivityProductsClassificationType EconomicActivityProductsClassificationType { get; set; }

        #region TreeData

        [ForeignKey("ParentId")]
        public virtual EconomicActivityProductsClassification Parent { get; set; }

        [InverseProperty("Parent")]
        public virtual IList<EconomicActivityProductsClassification> Children { get; set; }


        IBindingList ITreeNode.Children
        {
            get { return this.Children as IBindingList; }
        }
        ITreeNode IHCategory.Parent
        {
            get { return this.Parent as IHCategory; }
            set { this.Parent = value as EconomicActivityProductsClassification; }
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
