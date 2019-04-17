using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations.Schema;
using DevExpress.ExpressApp.DC;
using DevExpress.Persistent.Base;


namespace TreeNSI.Module.BusinessObjects
{
    [Table("view_TreeNSI_MeasurementUnit")]
    [DefaultClassOptions]
    public class vMeasurementUnit
    {
        [Key]
        public Int32 IdMeasurementUnit { get; set; }
        public string Code { get; set; }
        public string Name { get; set; }
        public String DomesticIdentificationCode { get; set; }
        public String InternationalIdentificationCode { get; set; }
        public string Description { get; set; }
        public String DomesticSymbolCode { get; set; }
        public String InternationalSymbolCode { get; set; }
        public bool? IsActive { get; set; }
        public String DomesticIdentificationCodeForPrint { get; set; }
        public String InternationalIdentificationCodeForPrint { get; set; }
        public string InternationalCode { get; set; }
        public bool? IsGroup { get; set; }
        public string ParentName { get; set; }
        public Int32? ParentId { get; set; }

    }
}


