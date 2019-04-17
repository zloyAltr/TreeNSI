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
    [Table("TreeNSI_CurrencyProperty")]
    [DefaultClassOptions]
    public class CurrencyProperty : IXafEntityObject, IObjectSpaceLink
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
        [FieldSize(100)]
        [StringLength(100)]
        [RuleRequiredField(DefaultContexts.Save)]
        public string Name { get; set; }
        [FieldSize(100)]
        [StringLength(100)]

        [ForeignKey("IdElement")]
        [RuleRequiredField(DefaultContexts.Save)]
        public virtual Currency Element { get; set; }

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
