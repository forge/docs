package org.jboss.forge.addons.envers.commands;

import org.jboss.forge.addon.configuration.Configuration;
import org.jboss.forge.addon.configuration.facets.ConfigurationFacet;
import org.jboss.forge.addon.parser.java.resources.JavaResource;
import org.jboss.forge.addon.projects.ProjectFactory;
import org.jboss.forge.addon.projects.Projects;
import org.jboss.forge.addon.ui.command.CommandExecutionListener;
import org.jboss.forge.addon.ui.command.UICommand;
import org.jboss.forge.addon.ui.context.UIExecutionContext;
import org.jboss.forge.addon.ui.context.UISelection;
import org.jboss.forge.addon.ui.result.Result;
import org.jboss.forge.roaster.model.source.JavaClassSource;

import javax.inject.Inject;
import java.io.FileNotFoundException;

import static org.jboss.forge.addons.envers.commands.Constants.AUDITED_ANNOTATION;
import static org.jboss.forge.addons.envers.commands.Constants.AUTO_AUDIT_CONFIG_ENTRY;

/**
 * @author Ivan St. Ivanov
 */
public class JpaEntityCreationListener implements CommandExecutionListener
{
   @Override public void preCommandExecuted(UICommand uiCommand, UIExecutionContext uiExecutionContext)
   {

   }

   @Inject
   private ProjectFactory projectFactory;

   @Override public void postCommandExecuted(UICommand uiCommand, UIExecutionContext uiExecutionContext, Result result)
   {
      String commandName = uiCommand
               .getMetadata(uiExecutionContext.getUIContext())
               .getName();
      if (commandName.equals("JPA: New Entity") && projectFactory != null)
      {
         Configuration configuration = Projects
                  .getSelectedProject(projectFactory, uiExecutionContext.getUIContext())
                  .getFacet(ConfigurationFacet.class)
                  .getConfiguration();
         if (configuration.getBoolean(AUTO_AUDIT_CONFIG_ENTRY, false))
         {
            try {
               JavaResource resource = (JavaResource) uiExecutionContext
                        .getUIContext().getSelection().get();
               JavaClassSource javaClass = resource.getJavaType();
               if (!javaClass.hasAnnotation(AUDITED_ANNOTATION)) {
                  javaClass.addAnnotation(AUDITED_ANNOTATION);
               }
               resource.setContents(javaClass);
            } catch (FileNotFoundException fnfe) {
               fnfe.printStackTrace();
            }
         }
      }
   }

   @Override public void postCommandFailure(UICommand uiCommand, UIExecutionContext uiExecutionContext,
            Throwable throwable)
   {

   }
}
