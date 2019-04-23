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
    [Table("TreeNSI_TransportRateClass")]
    [DefaultClassOptions]
    public class TransportRateClass : IHCategory, IXafEntityObject, IObjectSpaceLink
    {
        [Key, DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        [VisibleInDetailView(false), VisibleInListView(true), VisibleInLookupListView(true)]
        public Int32 IdTransportRateClass { get; protected set; }
        [Required]
        [RuleRequiredField(DefaultContexts.Save)]
        public bool? IsGroup { get; set; }
        public Int32? ParentId { get; set; }
        [FieldSize(6)]
        [StringLength(6)]
        public String Code { get; set; }
        [Required]
        [FieldSize(400)]
        [StringLength(400)]
        [RuleRequiredField(DefaultContexts.Save)]
        public string Name { get; set; }
        public int? Class { get; set; }
        [Required]
        [RuleRequiredField(DefaultContexts.Save)]
        public bool? IsActive { get; set; }

        public TransportRateClass()
        {
            Children = new BindingList<TransportRateClass>();
        }

        #region TreeData

        [ForeignKey("ParentId")]
        public virtual TransportRateClass Parent { get; set; }

        [InverseProperty("Parent")]
        public virtual IList<TransportRateClass> Children { get; set; }

        IBindingList ITreeNode.Children
        {
            get { return this.Children as IBindingList; }
        }
        ITreeNode IHCategory.Parent
        {
            get { return this.Parent as IHCategory; }
            set { this.Parent = value as TransportRateClass; }
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
