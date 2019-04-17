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
using DevExpress.Data.Filtering;

namespace TreeNSI.Module.BusinessObjects
{
    [Table("TreeNSI_ConformityAttestationDocument")]
    [DefaultClassOptions]
    [DefaultProperty("RegistrationNumber")]
    public class ConformityAttestationDocument : IXafEntityObject, IObjectSpaceLink
    {
        [Key]
        [VisibleInDetailView(false), VisibleInListView(true), VisibleInLookupListView(true)]
        public Int32 IdCADocument { get; protected set; }
        [Required]
        public Int32? IdCADocumentType { get; set; }
        [Required]
        [RuleRequiredField(DefaultContexts.Save)]
        [FieldSize(50)]
        [StringLength(50)]
        public string RegistrationNumber { get; set; }
        public DateTime? RegistrationDate { get; set; }
        public DateTime? ValidityPeriod { get; set; }
        [Required]
        [RuleRequiredField(DefaultContexts.Save)]
        public bool? IsActive { get; set; }
        [FieldSize(250)]
        [StringLength(250)]
        public String URLWebDocument { get; set; }

        [ForeignKey("IdCADocumentType")]
        [RuleRequiredField(DefaultContexts.Save)]
        public virtual ConformityAttestationDocumentType DocumentType { get; set; }

        #region IXafEntityObject
        #region initialization
        void IXafEntityObject.OnCreated()
        {
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
