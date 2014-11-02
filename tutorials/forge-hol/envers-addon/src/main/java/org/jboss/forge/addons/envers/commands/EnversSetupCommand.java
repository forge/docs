package org.jboss.forge.addons.envers.commands;

import org.jboss.forge.addon.dependencies.Dependency;
import org.jboss.forge.addon.dependencies.builder.DependencyBuilder;
import org.jboss.forge.addon.facets.constraints.FacetConstraint;
import org.jboss.forge.addon.projects.ProjectFacet;
import org.jboss.forge.addon.projects.ProjectFactory;
import org.jboss.forge.addon.projects.dependencies.DependencyInstaller;
import org.jboss.forge.addon.projects.ui.AbstractProjectCommand;
import org.jboss.forge.addon.ui.context.UIBuilder;
import org.jboss.forge.addon.ui.context.UIContext;
import org.jboss.forge.addon.ui.context.UIExecutionContext;
import org.jboss.forge.addon.ui.metadata.UICommandMetadata;
import org.jboss.forge.addon.ui.result.Result;
import org.jboss.forge.addon.ui.result.Results;
import org.jboss.forge.addon.ui.util.Categories;
import org.jboss.forge.addon.ui.util.Metadata;

import javax.inject.Inject;

import static org.jboss.forge.addons.envers.commands.Constants.*;

@FacetConstraint(ProjectFacet.class)
public class EnversSetupCommand extends AbstractProjectCommand
{

   @Inject
   private DependencyInstaller dependencyInstaller;

   @Override
   public UICommandMetadata getMetadata(UIContext context)
   {
      return Metadata.forCommand(EnversSetupCommand.class).name(
            "Envers: Setup").category(Categories.create("Auditing"));
   }

   @Override
   public void initializeUI(UIBuilder builder) throws Exception
   {
   }

   @Override
   public Result execute(UIExecutionContext context) throws Exception
   {
      Dependency dependency = DependencyBuilder
                     .create(HIBERNATE_GROUP_ID)
                     .setArtifactId(ENVERS_ARTIFACT_ID)
                     .setVersion("4.3.6.Final")
                     .setScopeType("provided");
      dependencyInstaller.install(getSelectedProject(context), dependency);
      return Results.success("Envers was successfully setup for the current project!");
   }

    @Override
    protected boolean isProjectRequired() {
        return true;
    }

    @Inject
    private ProjectFactory projectFactory;

    @Override
    protected ProjectFactory getProjectFactory() {
        return projectFactory;
    }
}