package org.jboss.forge.addons.envers.commands;

import org.jboss.forge.addon.dependencies.builder.DependencyBuilder;
import org.jboss.forge.addon.parser.java.resources.JavaResource;
import org.jboss.forge.addon.projects.ProjectFactory;
import org.jboss.forge.addon.projects.facets.DependencyFacet;
import org.jboss.forge.addon.projects.ui.AbstractProjectCommand;
import org.jboss.forge.addon.ui.context.UIBuilder;
import org.jboss.forge.addon.ui.context.UIContext;
import org.jboss.forge.addon.ui.context.UIExecutionContext;
import org.jboss.forge.addon.ui.context.UIValidationContext;
import org.jboss.forge.addon.ui.facets.HintsFacet;
import org.jboss.forge.addon.ui.hints.InputType;
import org.jboss.forge.addon.ui.input.UIInput;
import org.jboss.forge.addon.ui.metadata.UICommandMetadata;
import org.jboss.forge.addon.ui.metadata.WithAttributes;
import org.jboss.forge.addon.ui.result.Result;
import org.jboss.forge.addon.ui.result.Results;
import org.jboss.forge.addon.ui.util.Categories;
import org.jboss.forge.addon.ui.util.Metadata;
import org.jboss.forge.roaster.model.source.JavaClassSource;

import javax.inject.Inject;
import javax.persistence.Entity;
import java.io.FileNotFoundException;

import static org.jboss.forge.addons.envers.commands.Constants.*;

public class EnversAuditEntityCommand extends AbstractProjectCommand
{

   @Inject
   @WithAttributes(label = "Entity to audit", required = true)
   private UIInput<JavaResource> auditEntity;

   @Override
   public UICommandMetadata getMetadata(UIContext context)
   {
      return Metadata.forCommand(EnversAuditEntityCommand.class).name(
            "Envers: Audit entity").category(Categories.create("Auditing"));
   }

   @Override
   public void initializeUI(UIBuilder builder) throws Exception
   {
      auditEntity.getFacet(HintsFacet.class).setInputType(InputType.JAVA_CLASS_PICKER);
      Object selection = builder.getUIContext().getInitialSelection().get();
      if (selection instanceof JavaResource)
         auditEntity.setDefaultValue((JavaResource) selection);
      builder.add(auditEntity);
   }

   @Override
   public Result execute(UIExecutionContext context) throws Exception
   {
      JavaResource javaResource = auditEntity.getValue().reify(JavaResource.class);
      JavaClassSource javaClass = javaResource.getJavaType();
      if (!javaClass.hasAnnotation(AUDITED_ANNOTATION)) {
         javaClass.addAnnotation(AUDITED_ANNOTATION);
      }
      javaResource.setContents(javaClass);
      return Results
               .success("Entity " + javaClass.getQualifiedName() + " was successfully audited");
   }

   @Override
   public void validate(UIValidationContext validator)
   {
      super.validate(validator);
      try
      {
         if (!auditEntity.getValue().reify(JavaResource.class).getJavaType().hasAnnotation(Entity.class))
         {
            validator.addValidationError(auditEntity, "The selected class has to be JPA entity");
         }
      }
      catch (FileNotFoundException e)
      {
         validator.addValidationError(auditEntity, "You must select existing JPA entity to audit");
      }
   }

   @Override
   public boolean isEnabled(UIContext context)
   {
      return getSelectedProject(context).getFacet(DependencyFacet.class).hasEffectiveDependency(
               DependencyBuilder.create(HIBERNATE_GROUP_ID).setArtifactId(ENVERS_ARTIFACT_ID));
   }

   @Override
   protected boolean isProjectRequired()
   {
      return true;
   }

   @Inject
   private ProjectFactory projectFactory;

   @Override
   protected ProjectFactory getProjectFactory()
   {
      return projectFactory;
   }
}