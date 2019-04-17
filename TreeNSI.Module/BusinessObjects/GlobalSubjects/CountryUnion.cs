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
    [Table("TreeNSI_CountryUnion")]
    [DefaultClassOptions]
    public class CountryUnion : IXafEntityObject, IObjectSpaceLink
    {
        [Key]
        [VisibleInDetailView(false), VisibleInListView(true), VisibleInLookupListView(true)]
        public Int32 IdCountryUnion { get; protected set; }
        [Required]
        [FieldSize(50)]
        [StringLength(50)]
        [RuleRequiredField(DefaultContexts.Save)]
        public string Name { get; set; }
        [FieldSize(200)]
        [StringLength(200)]
        public string FullName { get; set; }
        [Required]
        [RuleRequiredField(DefaultContexts.Save)]
        public bool? IsActive { get; set; }

        [InverseProperty("CountryUnion")]
        public virtual IList<CountryUnionMember> Member { get; set; }

        public CountryUnion()
        {
            Member = new BindingList<CountryUnionMember>();
        }

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
