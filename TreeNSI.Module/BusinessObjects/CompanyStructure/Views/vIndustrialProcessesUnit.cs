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
    [Table("view_TreeNSI_IndustrialProcessesUnit")]
    [DefaultClassOptions]
    public class vIndustrialProcessesUnit : IHCategory
    {
        [Key]
        //[ForeignKey("IndustrialProcessesUnitOwner")]
        [VisibleInDetailView(false), VisibleInListView(true), VisibleInLookupListView(true)]
        public Int32 IdCatalog { get; protected set; }
        public string Name { get;  set; }
        public string DirectoryTypeName { get; protected set; }
        public bool? IsGroup { get; protected set; }
        public string ParentName { get; protected set; }
        public Int32? ParentId { get; set; }
        public string ParentDirectoryTypeName { get; protected set; }
        public Int32? ParentIdDirectoryType { get; protected set; }
        public DateTime? BeginDate { get; protected set; }
        public Int32? IdIndustrialProcessesUnit { get; protected set; }

        [ForeignKey("ParentId")]
        public virtual vIndustrialProcessesUnit Parent { get; set; }

        [InverseProperty("Parent")]
        public virtual IList<vIndustrialProcessesUnit> Children { get; set; }

        #region TreeData
        IBindingList ITreeNode.Children
        {
            get { return Children as IBindingList; }
        }
        ITreeNode IHCategory.Parent
        {
            get { return Parent as IHCategory; }
            set { Parent = value as vIndustrialProcessesUnit; }
        }
        ITreeNode ITreeNode.Parent
        {
            get { return Parent as ITreeNode; }
        }
        #endregion

        public vIndustrialProcessesUnit()
        {
            Children = new BindingList<vIndustrialProcessesUnit>();
        }

        //public virtual IndustrialProcessesUnitOwner IndustrialProcessesUnitOwner { get; set; }
    }
}
