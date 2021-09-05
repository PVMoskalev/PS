public with sharing class MySolutionService {

    // LAZY INITIALIZATION
    private SolutionSelector solutionSelectorInst {
        get {
            return (SolutionSelector) DependencyInjector.getInstance(SolutionSelector.class);
        }
    }
    private UserSelector userSelectorInst {
        get {
            return (UserSelector) DependencyInjector.getInstance(UserSelector.class);
        }
    }

    public MySolutionDTO getSolutionDTOs() {
        User user = this.userSelectorInst.getByUserId(CommunityUserInfo.getUserId());
        List<Solution__c> solutions = this.solutionSelectorInst.getByUserId(CommunityUserInfo.getUserId());

        /**
         * ANY BUSINESS LOGIC ONLY WITH SOBJECTS
         * EXCEPTIONS:
         * 1. DTOs that contains only their own fields, i.e., isSelected.
         */

        return MySolutionDTOMapper.toDTO(user, solutions);
    }
}