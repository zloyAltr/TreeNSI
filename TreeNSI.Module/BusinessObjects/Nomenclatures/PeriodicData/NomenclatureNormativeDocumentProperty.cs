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
    [Table("TreeNSI_NomenclatureNormativeDocumentProperty")]
    [DefaultClassOptions]
    public class NomenclatureNormativeDocumentProperty : IXafEntityObject, IObjectSpaceLink
    {
        [Key, DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        [VisibleInDetailView(false), VisibleInListView(true), VisibleInLookupListView(true)]
        public Int32 IdNormativeDocumentProperty { get; protected set; }

        [Required]
        [Browsable(false)]
        public Int32? IdNomenclature { get; set; }
        [Required]
        [RuleRequiredField(DefaultContexts.Save)]
        public DateTime? BeginDate { get; set; }
        [Required]
        public Int32? IdNormativeDocument { get; set; }
        [Required]
        [RuleRequiredField(DefaultContexts.Save)]
        public bool? IsActive { get; set; }

        [ForeignKey("IdNomenclature")]
        [RuleRequiredField(DefaultContexts.Save)]
        public virtual Nomenclature Nomenclature { get; set; }
        [ForeignKey("IdNormativeDocument")]
        [RuleRequiredField(DefaultContexts.Save)]
        public virtual vNormativeDocument NormativeDocument { get; set; }

        [NotMapped]
        public virtual string aName
        {
            get
            {
                return (NormativeDocument != null) ? NormativeDocument.NormativeDocumentNumber : "";
            }
        }

        #region IXafEntityObject
        #region initialization
        void IXafEntityObject.OnCreated()
        {
            BeginDate = DateTime.Now.Date;
            IsActive = true;

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
