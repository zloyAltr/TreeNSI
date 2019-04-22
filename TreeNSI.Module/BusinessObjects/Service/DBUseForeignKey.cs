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
    [Table("TreeNSI_DBUseForeignKey")]
    [DefaultClassOptions]
    [DefaultProperty("DBName")]
    public class DBUseForeignKey : IXafEntityObject, IObjectSpaceLink
    {
        [Key]
        [VisibleInDetailView(false), VisibleInListView(true), VisibleInLookupListView(true)]
        public Int32 IdDB { get; protected set; }
        [FieldSize(100)]
        [StringLength(100)]
        [Required]
        public string ServerName { get; set; }
        [FieldSize(100)]
        [StringLength(100)]
        [Required]
        [RuleRequiredField(DefaultContexts.Save)]
        public string DBName { get; set; }
        [FieldSize(100)]
        [StringLength(100)]
        [Required]
        [RuleRequiredField(DefaultContexts.Save)]
        public string SchemaName { get; set; }
        [FieldSize(250)]
        [StringLength(250)]
        [Required]
        [RuleRequiredField(DefaultContexts.Save)]
        public string DBDescription { get; set; }
        [Required]
        [RuleRequiredField(DefaultContexts.Save)]
        public bool? IsActive { get; set; }

        #region IXafEntityObject
        #region initialization
        void IXafEntityObject.OnCreated()
        {
            IsActive = true;
            SchemaName = "dbo";

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
