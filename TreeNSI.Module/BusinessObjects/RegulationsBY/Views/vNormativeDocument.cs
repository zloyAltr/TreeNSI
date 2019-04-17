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
    [Table("view_TreeNSI_NormativeDocument")]
    [DefaultClassOptions]
    [DefaultProperty("NormativeDocumentNumber")]
    public class vNormativeDocument
    {
        [Key]
        [VisibleInDetailView(false), VisibleInListView(true), VisibleInLookupListView(true)]
        public Int32 IdNormativeDocument { get; protected set; }
        public string NormativeDocumentStatusName { get; protected set; }
        public string NormativeDocumentTypeShortName { get; protected set; }
        public string NormativeDocumentTypeName { get; protected set; }
        public string NormativeDocumentNumber { get; protected set; }
        public string NormativeDocumentName { get; protected set; }
        public string ChangeDocumentTypeName { get; protected set; }
        public string ChangeDocumentNumber { get; protected set; }
        public DateTime? ChangeDocumentRegistrationDate { get; protected set; }
        public DateTime? NormativeDocumentRegistrationDate { get; protected set; }
        public DateTime? NormativeDocumentValidityStartDate { get; protected set; }
        public DateTime? NormativeDocumentValidityPeriod { get; protected set; }
        public int? IdNormativeDocumentStatus { get; protected set; }
        public int? IdChangeDocument { get; protected set; }
        public int? IdNormativeDocumentType { get; protected set; }
    }
}
