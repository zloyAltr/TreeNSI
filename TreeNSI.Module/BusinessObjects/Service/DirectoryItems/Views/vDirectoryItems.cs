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
    [Table("view_TreeNSI_DirectoryItems")]
    [DefaultClassOptions]
    public class vDirectoryItems : IHCategory
    {
        [Key]
        [VisibleInDetailView(true), VisibleInListView(true), VisibleInLookupListView(true)]
        public Int32 IdCatalog { get; protected set; }
        public Int32? IdElement { get; protected set; }
        public string Name { get; set; }
        public bool? IsGroup { get; protected set; }
        public Int32? ParentId { get;  set; }
        public string ParentName { get; protected set; }
        public Int32 IdTypeCatalog { get; protected set; }

        [ForeignKey("ParentId")]
        public virtual vDirectoryItems Parent { get; set; }

        [InverseProperty("Parent")]
        public virtual IList<vDirectoryItems> Children { get; set; }
        [ForeignKey("IdTypeCatalog")]
        public virtual DirectoryType DirectoryType { get; set; }

        public vDirectoryItems()
        {
            Children = new BindingList<vDirectoryItems>();
        }

        #region TreeData
        IBindingList ITreeNode.Children
        {
            get { return Children as IBindingList; }
        }
        ITreeNode IHCategory.Parent
        {
            get { return Parent as IHCategory; }
            set { Parent = value as vDirectoryItems; }
        }
        ITreeNode ITreeNode.Parent
        {
            get { return Parent as ITreeNode; }
        }
        #endregion
    }
}
