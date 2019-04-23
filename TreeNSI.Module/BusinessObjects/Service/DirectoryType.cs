using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations.Schema;
using DevExpress.ExpressApp.DC;
using DevExpress.Persistent.Base;
using DevExpress.Persistent.Validation;
using DevExpress.ExpressApp;


namespace TreeNSI.Module.BusinessObjects
{
    [Table("TreeNSI_DirectoryType")]
    [DefaultClassOptions]
    public class DirectoryType : IXafEntityObject, IObjectSpaceLink
    {
        [Key, DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        [VisibleInDetailView(false), VisibleInListView(true), VisibleInLookupListView(true)]
        public Int32 IdDirectoryType { get; protected set; }
        [Required]
        [FieldSize(100)]
        [StringLength(100)]
        [RuleRequiredField(DefaultContexts.Save)]
        public string Name { get; set; }
        [FieldSize(250)]
        [StringLength(250)]
        public string Description { get; set; }
        [Required]
        [FieldSize(100)]
        [StringLength(100)]
        [RuleRequiredField(DefaultContexts.Save)]
        public string TableName { get; set; }
        [Required]
        [RuleRequiredField(DefaultContexts.Save)]
        public bool? IsMultilevel { get; set; }
        [Required]
        [RuleRequiredField(DefaultContexts.Save)]
        public bool? IsPeriodic { get; set; }
        [Required]
        [RuleRequiredField(DefaultContexts.Save)]
        public bool? OnlyRegistation { get; set; }
        public bool? IsBaseStructure { get; set; }

        #region IXafEntityObject
        #region initialization
        void IXafEntityObject.OnCreated()
        {
            IsMultilevel = false;
            IsPeriodic = false;
            OnlyRegistation = false;

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
